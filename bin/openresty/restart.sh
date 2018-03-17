#!/bin/bash
set -euo pipefail

# Restart OpenResty proxy container
CONTAINER_NAME="openresty_proxy"

if docker ps -q -f name="${CONTAINER_NAME}" | grep -q .; then
    docker kill "${CONTAINER_NAME}" || true
fi

if docker ps -aq -f name="${CONTAINER_NAME}" | grep -q .; then
    docker rm "${CONTAINER_NAME}" || true
fi

docker-compose up -d "${CONTAINER_NAME}"
