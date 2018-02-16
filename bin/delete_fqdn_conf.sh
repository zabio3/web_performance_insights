#!/bin/bash

# 削除で変なことができるため制御が後ほど必要
# hostはダミー
curl -H "Host: DELETE" http://localhost:8082/deleteConfSet?fqdn=$1