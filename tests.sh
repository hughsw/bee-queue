#!/bin/sh

# Script used by the testing harness in the container run by ./docker-tests.sh

set -x

npx ava --no-color --serial --timeout 30000 --verbose

#npm run lint
exit

# The "official" test.  Fails when coveralls credentials aren't available
npm test
