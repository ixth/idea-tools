#!/usr/bin/env sh

set +e

PIDFILE=/var/run/yarn-dev-xhh.pid

if [ -f "$PIDFILE" ]; then
  xargs kill < "$PIDFILE"
fi

cd ~/codebase/hh.sites.main
yarn --non-interactive --force
yarn dev -s & echo $! > "$PIDFILE"
