#!/bin/bash
source ~/.profile_env

CUR_NAME="$(tmux display-message -p '#W')"
#NAME=$(echo '' | fzf-tmux -p -p 15%,7% --no-info --pointer=' ' --print-query -q "$CUR_NAME")
NAME=$(echo '' | $FZF_PATH/fzf-tmux -p 15%,6% --info=hidden --no-separator --pointer=' ' --print-query -q "$CUR_NAME")
[ $? -eq 130 ] && exit 0
[ "$NAME" == "" ] && exit 0
[ "$NAME" == "$CUR_NAME" ] && exit 0

CUR_WIN_ID=$(tmux display-message -p '#{window_id}' | sed 's/@//g')
SLAVE_SESSION=$(tmux list-sessions -F '#{session_name}' | grep "#$CUR_WIN_ID$")

tmux rename-window "$NAME"
if [ "$SLAVE_SESSION" != "" ]; then
    tmux rename-session -t "$SLAVE_SESSION" "$NAME #$CUR_WIN_ID"
fi
