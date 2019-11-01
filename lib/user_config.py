from os import environ, path
import json


DEFAULT_CONFIG_PATH = path.join(environ.get('HOME'), '.hh-idea-tools.json')


class UserConfig(dict):
    def __init__(self, config_path=DEFAULT_CONFIG_PATH, default=None):
        self._config_path = config_path
        self._config = self._load() or default or {}
        dict.__init__(self)

    def __getitem__(self, key):
        return dict.__getitem__(self._config, key)

    def __setitem__(self, key, val):
        return dict.__setitem__(self._config, key, val)

    def get_project_folders(self):
        return self._config.get('folders', {})

    def set_project_folders(self, folders):
        self._config['folders'] = folders

    def update_project_folders(self, new_folders):
        folders = self.get_project_folders()
        folders.update(new_folders)
        self.set_project_folders(folders)

    def get_project_folder(self, project_name):
        return self.get_project_folders().get(project_name, None)

    def set_project_folder(self, project_name, project_root_path):
        self.update_project_folders({project_name: project_root_path})

    def _load(self):
        try:
            config_file = open(self._config_path, 'r')
            return json.load(config_file)
        except (OSError, json.JSONDecodeError):
            return None

    def save(self):
        with open(self._config_path, 'w') as config_file:
            json.dump(self._config, config_file)
