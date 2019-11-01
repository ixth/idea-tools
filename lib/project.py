#!/usr/bin/env python3

from os import path
from lib.shell_tools import pick_folder

import importlib


class Project:
    def __init__(self, name, root_path):
        self._name = name
        self._config = Project.get_config(name)
        self._root_path = root_path

    @staticmethod
    def get_config(name):
        return importlib.import_module(f'project_config.{name}')

    def is_proper_root_path(self, root_path):
        return (
            root_path is not None and
            path.isfile(path.join(root_path, self._config.APP_MODULE_INIT_FILE))
        )

    def get_root_path(self):
        if self.is_proper_root_path(self._root_path):
            return self._root_path

        root_path = pick_folder(self._name)

        if not self.is_proper_root_path(root_path):
            raise BaseException(f'`{root_path}` is not proper project folder')

        return root_path

