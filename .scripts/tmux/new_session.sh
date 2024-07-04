#!/bin/bash
source ~/.profile_env
source $(dirname -- "${BASH_SOURCE[0]}")/common.sh

NAME=$(name_default)
[ $? -ne 0 ] && exit 0

TMUX='' tmux new-session -d -s $NAME
if [[ -z "$TMUX" ]]; then
    tmux attach -t $NAME
else
    tmux switch-client -t $NAME
fi
