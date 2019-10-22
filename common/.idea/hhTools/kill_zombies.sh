#!/usr/bin/env sh

if [ -f "$PIDFILE" ]; then
    xargs kill < "$PIDFILE" && rm "$PIDFILE"
fi
