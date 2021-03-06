#!/usr/bin/env sh

set +e

cd "$CODEBASE_PATH"
sudo chown -R hh:hh .
git fetch
git clean -dfx
git co -f master
git reset --hard origin/master
echo
git log -n 1
