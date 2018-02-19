docker ps | grep 'nuster_cache' | awk '{print "docker kill " $1}' | tail -1 | bash
docker ps -a | grep 'nuster_cache' | awk '{print "docker rm " $1}' | tail -1 | bash
docker-compose up -d nuster_cache