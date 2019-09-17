#!/usr/bin/env sh

tail -f /srv/hhmobile/var/log/service.slog | stdbuf -oL -eL jq -C .
