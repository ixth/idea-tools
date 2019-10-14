#!/usr/bin/env sh

set +e

cd ~/codebase/hhmobile
yarn --non-interactive --force
NODE_ENV=development yarn build
