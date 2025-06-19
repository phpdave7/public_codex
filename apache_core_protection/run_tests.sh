#!/bin/sh
set -e

docker build -t apache-core-protection .
container_id=$(docker run -d -p 8080:80 apache-core-protection)
# wait for the server to start
sleep 2

status=0
# Accessible file check
code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/index.html)
[ "$code" = "200" ] || status=1

# Core dump file should be forbidden
code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/core.1234)
[ "$code" = "403" ] || status=1

code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/core.dump)
[ "$code" = "403" ] || status=1

# cleanup
docker stop "$container_id"
exit $status
