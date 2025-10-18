#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "colorama"
# ]
# ///

import functools
import os
import pathlib
import subprocess
import sys
import typing

import colorama


class Logger:
    @classmethod
    def info(cls, message: typing.Any) -> None:
        print(f'{colorama.Fore.WHITE}{message}{colorama.Fore.RESET}')

    @classmethod
    def success(cls, message: typing.Any) -> None:
        print(f'{colorama.Fore.GREEN}{message}{colorama.Fore.RESET}')

    @classmethod
    def warning(cls, message: typing.Any) -> None:
        print(f'{colorama.Fore.YELLOW}{message}{colorama.Fore.RESET}')

    @classmethod
    def error(cls, message: typing.Any) -> None:
        print(f'{colorama.Fore.RED}{message}{colorama.Fore.RESET}')


logger = Logger


HOOKS_NAMES = (
    'applypatch-msg',
    'commit-msg',
    'fsmonitor-watchman',
    'post-update',
    'pre-applypatch',
    'pre-commit',
    'pre-merge-commit',
    'prepare-commit-msg',
    'pre-push',
    'pre-rebase',
    'pre-receive',
    'push-to-checkout',
    'sendemail-validate',
    'update'
)


class GitHooksInstaller:
    @functools.cached_property
    def _path_repo(self) -> pathlib.Path:
        proc = subprocess.run(
            ["git", "rev-parse", "--git-dir"],
            capture_output=True,
        )
        if proc.returncode == 0:
            path_repo = pathlib.Path(proc.stdout.decode().strip())
            if path_repo.exists():
                return path_repo

        raise Exception('current directory is not GIT repo')

    @functools.cached_property
    def _path_hooks(self) -> pathlib.Path:
        home_env = os.environ.get('HOME', '.')
        path_home = pathlib.Path(home_env)
        path_hooks = path_home / '.githooks'
        if path_hooks.exists():
            return path_hooks

        raise Exception('folder with GIT repo does not exists')

    @functools.cached_property
    def _python_hooks(self) -> tuple[pathlib.Path, ...]:
        return tuple(
            path for path in self._path_hooks.iterdir()
            if path.is_file() and path.stem in HOOKS_NAMES and path.suffix == '.py'
        )

    def _process(self) -> bool:
        success = True
        for python_hook in self._python_hooks:
            repo_hook = self._path_repo / 'hooks' / python_hook.stem
            if not repo_hook.exists():
                repo_hook.symlink_to(python_hook)
                logger.success(f'git hook "{python_hook.stem}" installed')
                continue

            if repo_hook.is_symlink() and repo_hook.readlink() == python_hook:
                logger.success(f'git hook "{python_hook.stem}" already exist')
                continue

            logger.warning(f'git hook conflict: {repo_hook}')
            success = False

        return success

    @classmethod
    def install(cls) -> bool:
        installer = cls()
        try:
            return installer._process()
        except Exception as e:
            logger.error(e)
            return False


if __name__ == '__main__':
    result = GitHooksInstaller.install()
    sys.exit(0 if result else 1)
