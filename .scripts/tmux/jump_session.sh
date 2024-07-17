#!/bin/bash
source ~/.profile_env

SESSION_NAME=$(tmux list-sessions -F '#{session_activity}:#{session_name}' | sort -r | awk -F ':' '{print $2}' | tail -n +2 | $FZF_PATH/fzf-tmux -p 20%,99% -x 10000)
[ $? -eq 130 ] && exit 0

tmux list-sessions -F '#{session_id} |#{session_name}|' | grep "|$SESSION_NAME|" > /dev/null
[ $? -ne 0 ] && exit 0

tmux switch-client -t "$SESSION_NAME"
