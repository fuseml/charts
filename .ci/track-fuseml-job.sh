#!/bin/bash

set -e
set -o pipefail

NS=fuseml-installer
retries=10

for i in $(seq ${retries}); do
    if [[ "${i}" == ${retries} ]]; then
        echo "Timeout waiting for installation pod to appear."
        exit 1
    fi
    if [[ -n "$(kubectl get pods -n $NS -l job-name=fuseml 2>/dev/null)" ]]; then
        break
    fi
    sleep 1
done

retries=40

for i in $(seq ${retries}); do
    if [[ "${i}" == ${retries} ]]; then
        echo "Timeout waiting for the installation to finish."
        exit 1
    fi
    pod_status=$(kubectl get pods -n $NS -l job-name=fuseml -o custom-columns=":status.phase" --no-headers)
    case ${pod_status} in
        Running|Pending) sleep 15 ;;
        Failed)
            echo "Installation has failed: "
            failed_pod=$(kubectl get pods -n $NS --field-selector=status.phase=Failed -o jsonpath='{.items[0].metadata.name}')
            kubectl describe pod $failed -n $NS
            kubectl logs $failed -n $NS
            exit 1
            ;;
        *) break ;;
    esac
done

exit 0
