#!/usr/bin/env bash

set -e

. helpers/config.sh --source-only
. helpers/ssh.sh --source-only
. helpers/copy.sh --source-only
. helpers/idea-config.sh --source-only

choose_folder() {
    OVERRIDE_SRC="$1"
    CONFIG_KEY_NAME="IDEA_TOOLS_FOLDERS_$OVERRIDE_SRC"
    FOLDER=${!CONFIG_KEY_NAME}
    if [ -z "$FOLDER" ]; then
        FOLDER=$(./helpers/choose-folder.sh "$OVERRIDE_SRC")
        declare "$CONFIG_KEY_NAME=$FOLDER"
        save_config
    fi
    echo "$FOLDER"
}

load_config
kindly_prompt_for_addition && add_ssh_config && include_ssh_config
copy_tools "mhh" "$(choose_folder MHH)" "hhmobile/__init__.py"
copy_tools "xhh" "$(choose_folder XHH)" "xhh/__init__.py"
build_idea_config
