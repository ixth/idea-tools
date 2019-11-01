#!/usr/bin/env bash

set -e

. helpers/config.sh --source-only
. helpers/ssh.sh --source-only

load_config
kindly_prompt_for_addition && add_ssh_config && include_ssh_config

python3 ./copy_tools.py mhh
python3 ./copy_tools.py xhh
python3 ./build_config.py
