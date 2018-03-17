#!/bin/bash
set -euo pipefail
[[ $# -eq 2 ]] || { echo "Usage: $0 <fqdn> <ngrok_address>" >&2; exit 1; }
curl -fsS -H "Host: $1" "http://localhost:8082/createConfSet?ngrok_address=$2"
