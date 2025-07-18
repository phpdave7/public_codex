#!/bin/sh
set -e
# This script assumes docker-compose up -d is running
sleep 2
code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/)
[ "$code" = "200" ]
