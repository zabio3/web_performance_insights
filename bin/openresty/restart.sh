docker ps | grep 'openresty_proxy' | awk '{print "docker kill " $1}' | tail -1 | bash
docker ps -a | grep 'openresty_proxy' | awk '{print "docker rm " $1}' | tail -1 | bash
docker-compose up -d openresty_proxy