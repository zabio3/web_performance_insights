#!/bin/bash
set -euo pipefail
[[ $# -eq 1 ]] || { echo "Usage: $0 <fqdn>" >&2; exit 1; }
curl -fsS -H "Host: DELETE" "http://localhost:8082/deleteConfSet?fqdn=$1"
