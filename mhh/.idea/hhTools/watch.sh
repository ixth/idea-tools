#!/usr/bin/env sh

PIDFILE=/var/run/yarn-dev.pid

if [ -f "$PIDFILE" ]; then
  xargs kill < "$PIDFILE"
fi

cd ~/codebase/hhmobile
yarn --non-interactive --force
yarn dev & echo $! > "$PIDFILE"
