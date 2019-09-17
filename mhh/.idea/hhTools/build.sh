#!/usr/bin/env sh

cd ~/codebase/hhmobile && \
yarn --non-interactive --force && \
NODE_ENV=development yarn build
