#!/bin/sh
set -e

# This script assumes the service has been started with
# `docker-compose up --build -d` and is reachable on localhost:8080.
# Wait briefly to ensure the server is ready.
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

exit $status
