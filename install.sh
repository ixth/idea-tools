#!/bin/sh

set -e

ssh_dir="$HOME/.ssh"
config="$ssh_dir/config"
nl="$(printf '%b_' '\n')"; nl="${nl%_}"

get_stand_subdomain() {
    local _stand
    read -p "Stand (just subdomain, i.e. 'bear', 'ts99'): " _stand

    if ! nslookup "$_stand" 1>/dev/null; then
        if ! prompt "Can't resolve $stand.pyn.ru. Continue anyway?"; then
            exit 1
        fi
    fi

    echo "$_stand"
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

has_ssh_config() {
    grep -xq "^Host dev" "$1"
}

add_ssh_config() {
    if has_ssh_config "$config"; then
        if ! prompt "It seems like dev host has already been added to $config.
Wanna add it anyway (either ways you'll be able to edit later)?"; then
            return
        fi
    else
        if ! prompt "I'm going to add 'dev' host alias to your ssh config, ok?"; then
            return
        fi
    fi

    mkdir -p "$ssh_dir"

    sed "1 a\\$nl; s/%/$(get_stand_subdomain)/" ssh/dev >> "$HOME/.ssh/config"
}

copy_tools() {
    if test -n "$1" && test -e "$2/$3"; then
        cp -v -pR "$1/" "$2"
    fi
}

build_idea_config() {
    (cd tools && \
    zip -qr ../tools.jar * && \
    echo "Now import tools.jar via 'File > Import Settings' menu in IntelliJ IDEA")
}

add_ssh_config
copy_tools "mhh" "$(./choose-folder.sh mhh)" "hhmobile/__init__.py"
copy_tools "xhh" "$(./choose-folder.sh xhh)" "xhh/__init__.py"
build_idea_config
