[OpenResty](https://openresty.org/en/)
===

## Overview

For performance tuning and measurement automation of origin content.

## Details

OpenResty Lua automatically rewrites target FQDN config when accessing from local environment with specific headers.

 - Rewrite by requesting the ngrok-issued FQDN

#### Content Compression

 - Place compressed content based on PageSpeed Insights results. Return content via location path matching.
    - Writing compressed content paths is outside the scope of Dockerfile
    - Automate this with a dedicated content compression server

##### Setup

```
docker-compose build --no-cache openresty_proxy
docker-compose up -d openresty_proxy
```

 - Place nginx.conf and files under conf.d directory

For automatic file creation (creating nginx group and adding to root would be more secure, but skipping for this test environment):

```
chmod 777 /etc/nginx/conf.d/./
```

##### View Logs

```docker
docker-compose logs -f openresty_proxy
```

## Notes
 - Lua requires write permission to target directory for automatic conf file generation
 - Lua variable reference
    - https://gist.github.com/ykst/52205d4d4968298137ea0050c4569170
 - Consider deleting or externalizing logs

## Error Notes
 - [Disable cache when building with docker-compose](https://qiita.com/setouchi/items/e01557ae4647b8e3b1bc)
    - Dockerfile changes weren't applied sometimes (nginx.conf changes weren't reflected)
 - COPY failed: Forbidden path outside the build context: ../openresty/nginx.conf ()
    - Dockerfile COPY can only copy files under the command execution directory
 - COPY failed: stat /var/lib/docker/tmp/docker-builder425834845/nginx.conf: no such file or directory
    - [Reported as a bug in issues](https://github.com/openresty/docker-openresty/issues/64)
    - Manual copy is not ideal (temporary workaround: use volume mount)

## References

 - [docker-openresty](https://github.com/openresty/docker-openresty)
