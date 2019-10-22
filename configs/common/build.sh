#!/usr/bin/env sh

set +e

cd "$CODEBASE_PATH"
yarn --non-interactive --force
NODE_ENV=development yarn build
