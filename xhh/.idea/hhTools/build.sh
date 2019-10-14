#!/usr/bin/env sh

set +e

cd ~/codebase/hh.sites.main
yarn --non-interactive --force
NODE_ENV=development yarn build
