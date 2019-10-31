#!/usr/bin/env bash

IDEA_TOOLS_CONFIG="$HOME/.idea-tools/.env"

load_config() {
    if [ -f "$IDEA_TOOLS_CONFIG" ]; then
        # shellcheck disable=SC1090
        . "$IDEA_TOOLS_CONFIG" --source-only
    fi
}

save_config() {
    mkdir -p "$(dirname "$IDEA_TOOLS_CONFIG")"
    set | grep '^IDEA_TOOLS_' > "$IDEA_TOOLS_CONFIG"
}
