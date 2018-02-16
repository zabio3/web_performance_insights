#!/bin/bash

# $1 host name
# $2 ngrok_address
curl -H "Host: $1" http://localhost:8082/createConfSet?ngrok_address=$2