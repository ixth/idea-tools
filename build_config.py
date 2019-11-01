#!/usr/bin/env python3

from os import path, environ
import subprocess


def build_idea_config():
    home_dir = environ.get('HOME', '.')
    tools_dest_path = path.join(home_dir, 'Desktop/tools.jar')
    result = subprocess.run(
        ['zip', '-qr', tools_dest_path, '--', '.', '-i *'],
        cwd='tools',
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    if result.returncode > 0:
        # TODO: more sane error handling
        raise BaseException(f'Something went wrong:\n{result.stdout}\n{result.stderr}')

    print('Now import tools.jar via "File > Import Settings" menu in IntelliJ IDEA')


if __name__ == '__main__':
    build_idea_config()
