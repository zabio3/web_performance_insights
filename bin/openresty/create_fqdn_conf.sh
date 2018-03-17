#!/bin/bash
set -euo pipefail

# Create FQDN configuration for OpenResty proxy
# Usage: ./create_fqdn_conf.sh <target_fqdn> <ngrok_address>

usage() {
    echo "Usage: $0 <target_fqdn> <ngrok_address>" >&2
    echo "  target_fqdn:   Target domain to proxy" >&2
    echo "  ngrok_address: ngrok tunnel address" >&2
    exit 1
}

if [[ $# -ne 2 ]]; then
    usage
fi

TARGET_FQDN="$1"
NGROK_ADDRESS="$2"

curl -fsS -H "Host: ${TARGET_FQDN}" \
    "http://localhost:8082/createConfSet?ngrok_address=${NGROK_ADDRESS}"
