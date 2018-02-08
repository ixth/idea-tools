#!/bin/sh

set -e

global_gitignore=`git config --global core.excludesfile`

add_global_gitignore() {
    if test -n global_gitignore; then
        git config --global core.excludesfile $HOME/.gitignore
    fi
}

ignore_tools() {
    if ! grep -Fxq "^hh-dev-tools/" "$global_gitignore"; then
        echo "hh-dev-tools/" >> "$global_gitignore"
    fi
}

get_stand_subdomain() {
    local _stand
    read -p "Stand (just subdomain, i.e. 'bear', 'ts99'): " _stand

    if ! nslookup "$_stand" 1>/dev/null; then
        if ! prompt "Can't resolve $stand.pyn.ru, are you sure there's no mistake?"; then
            exit 1
        fi
    fi

    if test -n "$1"; then
        eval "$1=\$_stand"
    fi
}

prompt() {
    local yn
    while true; do
        read -p "$1 [y/n] " yn
        case $yn in
            [Yy]* ) return 0; break;;
            [Nn]* ) return 1; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

add_ssh_config() {
   if ! prompt "I'm going to add 'dev' and 'tunnel' host aliases to your ssh config, ok?"; then
       return
   fi

    local stand
    get_stand_subdomain stand

    ssh_dir="$HOME/.ssh"
    if ! test -d "$ssh_dir"; then
        mkdir "$ssh_dir"
    fi

    if ! grep -xq "^Host dev" "$HOME/.ssh/config"; then
        sed '1s/^/\
/; s/%/'$stand'/' ssh/dev >> "$HOME/.ssh/config"
    fi

    if ! grep -xq "^Host tunnel" "$HOME/.ssh/config"; then
        sed '1s/^/\
/; s/%/'$stand'/' ssh/tunnel >> "$HOME/.ssh/config"
    fi
}

copy_tools() {
    if test -n "$1" && test -e "$2/$3"; then
        cp -v -R "$1/" "$2"
    fi
}

build_idea_config() {
    (cd tools && \
    zip -qr ../tools.jar * && \
    echo "Now import tools.jar via 'File > Import Settings' menu in IntelliJ IDEA")
}

add_global_gitignore
ignore_tools
add_ssh_config
copy_tools "mhh" `osascript choose-folder.js mhh 2>/dev/null` "hhmobile/__init__.py"
copy_tools "xhh" `osascript choose-folder.js xhh 2>/dev/null` "xhh/__init__.py"
build_idea_config
