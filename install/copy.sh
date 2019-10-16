#!/usr/bin/env sh

copy_tools() {
    if [ -n "$1" ] && [ -e "$2/$3" ]; then
        cp -v -pR "$1/" "$2"
    fi
}

