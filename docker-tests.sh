#!/bin/bash

# Build a Docker image and run tests in a container on a virtual network with an ephemeral Redis server container
# See ./tests.sh for commands that get run in the container

# Strict and loud failure
set -euo pipefail
trap 'rc=$?;set +ex;if [[ $rc -ne 0 ]];then trap - ERR EXIT;echo 1>&2;echo "*** fail *** : code $rc : $DIR/$SCRIPT $ARGS" 1>&2;echo 1>&2;exit $rc;fi' ERR EXIT
ARGS="$*"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$(basename "${BASH_SOURCE[0]}")"

cd $DIR

set -x

# Housekeeping and build
docker-compose --file docker-compose-tests.yml down || true
docker-compose --file docker-compose-tests.yml build
# Run Redis and the tests
docker-compose --file docker-compose-tests.yml up --force-recreate --renew-anon-volumes --remove-orphans --abort-on-container-exit --timeout 3

set +x
