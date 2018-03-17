#!/bin/bash
set -euo pipefail

# Delete FQDN configuration from OpenResty proxy
# Usage: ./delete_fqdn_conf.sh <target_fqdn>

usage() {
    echo "Usage: $0 <target_fqdn>" >&2
    echo "  target_fqdn: Target domain configuration to delete" >&2
    exit 1
}

if [[ $# -ne 1 ]]; then
    usage
fi

TARGET_FQDN="$1"

curl -fsS -H "Host: DELETE" \
    "http://localhost:8082/deleteConfSet?fqdn=${TARGET_FQDN}"
