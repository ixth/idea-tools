#!/usr/bin/env sh

if [ -f "$PIDFILE" ]; then
    xargs kill < "$PIDFILE"
fi

cd "$CODEBASE_PATH"
yarn --non-interactive --force
yarn dev -s & echo $! > "$PIDFILE"
