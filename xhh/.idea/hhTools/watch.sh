#!/usr/bin/env sh

set +e

cd ~/codebase/hh.sites.main
yarn --non-interactive --force
yarn dev -s
