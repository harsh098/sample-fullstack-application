#!/bin/bash

#Credits: https://blog.harrison.dev/2016/06/19/integration-testing-with-docker-compose.html

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
cleanup () {
  docker-compose -p ci kill
  docker-compose -p ci rm -f
}
trap 'cleanup ; printf "${RED}Tests Failed For Unexpected Reasons${NC}\n"' HUP INT QUIT PIPE TERM
docker-compose -p ci -f docker-compose.yml -f docker-compose.tests.yml build && docker-compose -p ci -f docker-compose.yml -f docker-compose.tests.yml up -d
if [ $? -ne 0 ] ; then
  printf "${RED}Docker Compose Failed${NC}\n";
  cleanup
  exit -1
fi
docker compose -p ci wait backend
TEST_EXIT_CODE=$?
docker compose -p ci logs backend
if [ "$TEST_EXIT_CODE" -ne 0 ] ; then
  docker compose -p ci logs postgres
  docker compose -p ci logs redis
  docker compose -p ci logs backend
  printf "${RED}Tests Failed${NC} - Exit Code: $TEST_EXIT_CODE\n"
  cleanup
  exit $TEST_EXIT_CODE
else
  printf "${GREEN}Tests Passed${NC}\n"
fi
cleanup
