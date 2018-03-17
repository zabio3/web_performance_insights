#!/bin/bash
set -euo pipefail

# Restart Nuster cache container
CONTAINER_NAME="nuster_cache"

if docker ps -q -f name="${CONTAINER_NAME}" | grep -q .; then
    docker kill "${CONTAINER_NAME}" || true
fi

if docker ps -aq -f name="${CONTAINER_NAME}" | grep -q .; then
    docker rm "${CONTAINER_NAME}" || true
fi

docker-compose up -d "${CONTAINER_NAME}"
