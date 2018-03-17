[Nuster](https://github.com/jiangwenyuan/nuster)
===

## Overview

HAProxy-based caching proxy server.

## Details

##### Reload Configuration

```
/usr/local/sbin/haproxy -f ./nuster.cfg
```

##### Clear Cache

```docker
curl -XPURGE http://localhost:8080
```

## Notes
 - [macOS Volume Specification (must use absolute path)](https://docs.docker.com/docker-for-mac/osxfs/#namespaces)

## References
 - [Nuster Introduction](https://qiita.com/kbe/items/d366d7a387de3d18fb96)
