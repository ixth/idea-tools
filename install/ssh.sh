#!/usr/bin/env sh

ssh_dir="$HOME/.ssh"
ssh_config_file="$ssh_dir/config"
dev_config_file="$ssh_dir/config.d/pyn.ru"
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
    local _stand
    read -p "Stand (just subdomain, i.e. 'bear', 'ts99'): " _stand

    if ! nslookup "$_stand" 1>/dev/null; then
        if ! prompt "Can't resolve $_stand.pyn.ru. Continue anyway?"; then
            exit 1
        fi
    fi

    echo "$_stand"
}

get_include_string() {
    relative_path=$(realpath "$dev_config_file" --relative-to="$ssh_dir")
    echo "Include $relative_path"
}

has_ssh_config() {
    [ -f "$dev_config_file" ]
}

has_ssh_config_included() {
    grep -xq "^$(get_include_string)" "$1"
}

add_ssh_config() {
    if has_ssh_config || has_ssh_config_included "$ssh_config_file"; then
        if ! prompt "It seems like dev host has already been added to $ssh_config_file.
Do you want to add it anyway (either ways you'll be able to edit it later)?"; then
            return
        fi
    else
        if ! prompt "I'm going to add 'dev' host alias to your ssh config, ok?"; then
            return
        fi
    fi

    mkdir -p "$ssh_dir/config.d"

    sed "s/%/$(get_stand_subdomain)/" ssh/dev > "$dev_config_file"
}

include_ssh_config() {
    echo "${nl}$(get_include_string)" >> "$ssh_config_file"
}
