#!/usr/bin/env bash

ssh_dir="$HOME/.ssh"
nl="$(printf '%b_' '\n')"; nl="${nl%_}"

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

get_stand_subdomain() {
    local stand
    read -rp "Stand (just subdomain, i.e. 'bear', 'ts99'): " stand

    if ! nslookup "$stand" 1>/dev/null; then
        if ! prompt "Can't resolve $stand.pyn.ru. Continue anyway?"; then
            exit 1
        fi
    fi

    echo "$stand"
}

has_dev_config() {
    [ -f "$ssh_dir/config.d/dev" ]
}

get_dev_config_include_string() {
    echo "Include config.d/dev"
}

has_dev_config_included() {
    grep -xq "^$(get_dev_config_include_string)" "$ssh_dir/config"
}

kindly_prompt_for_addition() {
    if [ "$FORCE" = "1" ]; then
        return 0
    fi

    if [ "$SILENT" = "1" ]; then
        return 1
    fi

    if has_dev_config && has_dev_config_included; then
        prompt "It seems like dev host has already been added to $ssh_dir/config.
Do you want to add it anyway (either ways you'll be able to edit it later)?"
    else
        prompt "I'm going to add 'dev' host alias to your ssh config, ok?"
    fi
}

add_ssh_config() {
    mkdir -p "$ssh_dir/config.d"
    cp ssh/dev "$ssh_dir/config.d/"
    sed -i~ "s/%stand%/$(get_stand_subdomain)/" "$ssh_dir/config.d/dev"
}

include_ssh_config() {
    echo "${nl}$(get_dev_config_include_string)" >> "$ssh_dir/config"
}
