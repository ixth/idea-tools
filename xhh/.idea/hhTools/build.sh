#!/usr/bin/env sh

cd ~/codebase/hh.sites.main && \
yarn --non-interactive --force && \
NODE_ENV=development yarn build
