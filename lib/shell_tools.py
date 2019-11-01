from os import path
import subprocess


def pick_folder(project_name):
    result = subprocess.run(
        ['osascript', 'helpers/choose-folder.js', project_name],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )

    if result.returncode > 0:
        # TODO: more sane error handling
        raise BaseException(f'Something went wrong: {result.stderr}')

    return result.stdout.decode('utf-8').strip()


def copy(*argv, dest):
    subprocess.run(['cp', '-vpR', *argv, dest])


def ensure_dir(dir_path):
    if not path.exists(dir_path):
        subprocess.run(['mkdir', '-p', dir_path])
