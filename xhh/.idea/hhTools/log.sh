#!/usr/bin/env sh

tail -f /srv/frontik/var/log/service.slog | stdbuf -oL -eL jq -C .
