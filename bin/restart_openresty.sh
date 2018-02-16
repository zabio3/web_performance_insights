docker ps | grep 'openresty_proxy' | awk '{print "docker kill " $1}' | tail -1 | bash
docker-compose up -d openresty_proxy