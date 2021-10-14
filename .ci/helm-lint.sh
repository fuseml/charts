#!/bin/bash
set -euo pipefail

# run the entire script and exit with 1, when an error occured
EXIT_CODE=0

# List of directories which contains helm charts.
DIRS=($(find `ls -d */*` -maxdepth 0 -type d))

if [ "${#DIRS[@]}" -eq 0 ]; then
    echo "No charts were modified."
    exit 0
fi

# helm package test
for dir in "${DIRS[@]}"; do
  pushd "${dir}"
  echo "Packaging chart ${dir}..."
  helm package . ||  EXIT_CODE=$?
  popd
done

# helm lint test
for dir in "${DIRS[@]}"; do
  echo "Linting chart ${dir}..."
  pushd "${dir}"
  helm lint "${helm_args[@]}" . || EXIT_CODE=$?
  popd
done

exit ${EXIT_CODE}
