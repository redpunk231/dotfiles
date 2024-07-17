#!/bin/bash
source ~/.profile_env

NAME=$(echo '' | $FZF_PATH/fzf-tmux -p 15%,6% --info=hidden --no-separator --pointer=' ' --print-query | sed 's/\ /_/g')
[ $? -eq 130 ] && exit 0

if [ "$NAME" == "" ]; then
    NAME=$(uuidgen)
fi

TMUX='' tmux new-session -d -s $NAME -c "~/"
if [[ -z "$TMUX" ]]; then
    tmux attach -t $NAME
else
    tmux switch-client -t $NAME
fi
