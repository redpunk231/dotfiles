#!/bin/bash
source ~/.profile_env

DIR="~/"
SESSION_ID=$(tmux display-message -p '#{session_id}')

if [ "$SESSION_ID" != '$0' ]; then
    if [ /tmp/tmux/PWD_$SESSION_ID ]; then
        DIR="$(cat /tmp/tmux/PWD_$SESSION_ID)"
    fi
fi

tmux new-window -a -c "$DIR"
