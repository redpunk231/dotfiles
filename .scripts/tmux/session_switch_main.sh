#!/bin/bash
source ~/.profile_env

#OTHER=$(tmux list-sessions -F '#{session_attached}: #{session_last_attached}: #S' | sort -r | grep -v '^1' | sed 's/.*: //g')

DEFAULT_NAME_DETECT='zsh bash nvim vim mc'

CUR_WIN=$(tmux list-windows -F '#{window_active}:#{window_id}:#{window_name}:#{session_name}' | grep '^1' | sed 's/^1://g')
CUR_WIN_ID=$(echo $CUR_WIN | awk -F ':' '{print $1}' | sed 's/@//g')
CUR_WIN_NAME=$(echo $CUR_WIN | awk -F ':' '{print $2}')
CUR_WIN_SESSION=$(echo $CUR_WIN | awk -F ':' '{print $3}')


echo "$CUR_WIN_SESSION" | grep '#[0-9]*$' > /dev/null
if [ $? -eq 0 ]; then
    WIN_ID=$(echo "$CUR_WIN_SESSION" | sed 's/.*#//g')

    tmux switch-client -t main
    if [ "$1" != "on_close" ]; then
        tmux select-window -t "@$WIN_ID"
    fi
fi

if [ "$1" == "on_close" ]; then
    exit 0
fi


if [ "$CUR_WIN_SESSION" == "main" ]; then
    echo " $DEFAULT_NAME_DETECT " | grep -o " $CUR_WIN_NAME " > /dev/null
    if [ $? -eq 0 ]; then
        SESSION_NAME="#$CUR_WIN_ID"
    else
        SESSION_NAME="$CUR_WIN_NAME #$CUR_WIN_ID"
    fi

    tmux list-sessions -F '#{session_name}' | grep "#$CUR_WIN_ID$" > /dev/null
    if [ $? -ne 0 ]; then
        SESSION_PATH=$(tmux display-message -p '#{pane_current_path}')
        #tmux new-session -d -s "$SESSION_NAME" -c "$SESSION_PATH"

        SESSION_ID=$(tmux new-session -d -s "$SESSION_NAME" -c "$SESSION_PATH" -P -F '#{session_id}')
        mkdir -p /tmp/tmux
        echo "$SESSION_PATH" > /tmp/tmux/PWD_$SESSION_ID
    fi

    tmux switch-client -t "$SESSION_NAME"
    exit 0
fi

