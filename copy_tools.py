#!/usr/bin/env python3

import sys
from os import path

from lib.shell_tools import copy, ensure_dir
from lib.user_config import UserConfig
from lib.project import Project

user_config = UserConfig()


def copy_tools(project_name):
    project = Project(project_name, root_path=user_config.get_project_folder(project_name))
    root_path = project.get_root_path()
    user_config.set_project_folder(project_name, root_path)
    user_config.save()

    common_dir = path.join('configs', 'common')
    overrides_dir = path.join('configs', project_name)
    if path.isdir(common_dir) and path.isdir(overrides_dir):
        dest_dir = path.join(root_path, '.idea/hhTools')
        ensure_dir(dest_dir)
        copy(f'{common_dir}/', f'{overrides_dir}/', dest=f'{dest_dir}/')


if __name__ == '__main__':
    copy_tools(sys.argv[1])
