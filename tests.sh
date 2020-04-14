#!/bin/sh

set -x

npx ava --no-color --serial --timeout 21000 --verbose

npm run eslint
exit

# The "official" test
npm test
