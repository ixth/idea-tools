#!/usr/bin/env bash

IDEA_TOOLS_CONFIG="$HOME/.idea-tools/.env"
IDEA_TOOLS_CONFIG_DIR=$(dirname "$IDEA_TOOLS_CONFIG")

load_config() {
    if [ -f "$IDEA_TOOLS_CONFIG" ]; then
        # shellcheck disable=SC1090
        . "$IDEA_TOOLS_CONFIG" --source-only
    fi
}

save_config() {
    mkdir -p "$IDEA_TOOLS_CONFIG_DIR"
    set | grep '^IDEA_TOOLS_' > "$IDEA_TOOLS_CONFIG"
}
