#!/bin/bash

set -e
set -o pipefail

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
k3d version

CLUSTER_SUFIX=$(git symbolic-ref -q --short HEAD 2>/dev/null || git describe --tags --exact-match --short HEAD 2>/dev/null || git describe --all | tr '/' - | tr _ - )
CLUSTER_NAME=charts-${CLUSTER_SUFIX//[!A-Za-z0-9-]/-}

k3d_args="--k3s-arg --disable=traefik@server:* --agents 1"

# Create cluster
echo "k3d cluster create ${k3d_args} ${CLUSTER_NAME}"
k3d cluster create ${k3d_args} ${CLUSTER_NAME}
