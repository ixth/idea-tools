#!/bin/sh

set -e

global_gitignore=`git config --global core.excludesfile`

add_global_gitignore() {
    if test -n global_gitignore; then
        git config --global core.excludesfile $HOME/.gitignore
    fi
}

ignore_tools() {
    if ! grep -Fxq "hh-dev-tools/" "$global_gitignore"; then
        echo "hh-dev-tools/" >> "$global_gitignore"
    fi
}

copy_tools() {
    if test -n "$1" && test -e "$2/$3"; then
        mkdir -p "$2/hh-dev-tools"
        cp -v $1/* "$2/hh-dev-tools"
    fi
}

build_idea_config() {
    (cd tools && \
    zip -qr ../tools.jar * && \
    echo 'Now import tools.jar via `File > Import Settings` menu in IntelliJ IDEA')
}

add_global_gitignore
ignore_tools
copy_tools "mhh" `osascript choose-folder.js mhh 2>/dev/null` "hhmobile/__init__.py"
copy_tools "xhh" `osascript choose-folder.js xhh 2>/dev/null` "xhh/__init__.py"
build_idea_config
