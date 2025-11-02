#!/usr/bin/env -S uv run --script
# /// script
# dependencies = [
#   "python-dotenv"
# ]
# ///

# Git hooks for preparing a commit message

import abc
import os
import pathlib
import re
import subprocess
import sys
import typing

from dotenv import load_dotenv


def load_envs() -> None:
    home = os.getenv('HOME', '.')
    envs = pathlib.Path(home).joinpath('.local_env')
    if envs.is_file():
        load_dotenv(home)


class ProtoPrepareMessageHook(abc.ABC):
    def __init__(self, msg_path: str) -> None:
        self._msg_path = pathlib.Path(msg_path)

    @property
    @abc.abstractmethod
    def _is_enabled(self) -> bool: ...

    @abc.abstractmethod
    def _process(self) -> bool: ...

    def __call__(self) -> bool:
        if not self._is_enabled:
            return True
        return self._process()


class JIRATicketHook(ProtoPrepareMessageHook):
    regex_tiket = r'^[A-Z]{1,}-[0-9]{1,}'

    @property
    def _is_enabled(self) -> bool:
        return os.getenv('GIT_PREPARE_MESSAGE_JIRA_TICKET') == '1' or True

    def _process(self) -> bool:
        branch = self._get_current_branch()
        if (ticket := self._get_jira_ticket(branch)) is None:
            return True

        commit_message = self._msg_path.read_text()
        if self._check_containt_ticket(ticket, commit_message):
            return True

        self._msg_path.write_text(f'{ticket} - {commit_message}')
        return True

    def _get_current_branch(self) -> str:
        branch = subprocess.check_output(["git", "symbolic-ref", "--short", "HEAD"])
        return branch.decode("utf-8").strip()

    def _get_jira_ticket(self, branch: str) -> typing.Optional[str]:
        ticket_match = re.match(self.regex_tiket, branch)
        if ticket_match is None:
            return None
        return ticket_match.group(0)

    def _check_containt_ticket(self, ticket: str, message: str) -> bool:
        return any(
            not line.startswith('#') and ticket in line
            for line in message.splitlines()
        )


if __name__ == '__main__':
    load_envs()
    hooks = (
        JIRATicketHook(sys.argv[1]),
    )
    sys.exit(0 if all(hook() for hook in hooks) else 1)
