#!/bin/sh

set -e

. install/ssh.sh --source-only
. install/copy.sh --source-only
. install/idea-config.sh --source-only

add_ssh_config
copy_tools "mhh" "$(./choose-folder.sh mhh)" "hhmobile/__init__.py"
copy_tools "xhh" "$(./choose-folder.sh xhh)" "xhh/__init__.py"
build_idea_config
