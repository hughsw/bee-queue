#!/bin/bash

# Build a Docker image and use it to run tests via docker-compose

# strict and loud failure
set -euo pipefail
trap 'rc=$?;set +ex;if [[ $rc -ne 0 ]];then trap - ERR EXIT;echo 1>&2;echo "*** fail *** : code $rc : $DIR/$SCRIPT $ARGS" 1>&2;echo 1>&2;exit $rc;fi' ERR EXIT
ARGS="$*"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$(basename "${BASH_SOURCE[0]}")"

cd $DIR

set -x

# Establish a clean slate for Redis, see volumes in docker-compose.yml
redisDataDir=./.redisData
touch $redisDataDir
rm -r $redisDataDir
mkdir -p $redisDataDir

# Run Redis and the tests
docker-compose  --file docker-compose-tests.yml  up  --build  --force-recreate  --remove-orphans  --abort-on-container-exit  --timeout 3

set +x
