#!/usr/bin/env bash

prompt_for_path() {
    local _path
    while true; do
        read -p "Enter path: " _path

        if [ ! -e "$_path" ]; then
            echo "Path $_path does not exist" >&2
            continue
        fi

        if [ ! -d "$_path" ]; then
            echo "$_path is not directory" >&2
            continue
        fi

        break
    done
    echo "$_path"
}

command_exists() {
    command -v "$1" > /dev/null
}

if command_exists osascript; then
    SCRIPT_DIR=$(dirname "$0")
    osascript "$SCRIPT_DIR/choose-folder.js" "$@" 2>/dev/null
else
    prompt_for_path
fi
