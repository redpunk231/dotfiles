#!/bin/bash
source ~/.profile_env

# --bind 'alt-d:execute-silent(tmux kill-session -t {})+abort' \

SESSION_NAME=$(\
    tmux list-sessions -F '#{session_activity}:#{session_name}' | sort -r | awk -F ':' '{print $2}' | tail -n +2 | \
    $FZF_PATH/fzf-tmux -p 20%,99% -x 10000 \
        --preview "tmux list-windows -t {} -F '#{window_active} #{window_name} [#{window_panes} panes]' | sed 's/^1/*/g' | sed 's/^0/\ /g'" \
        --preview-window up,33%,border-none \
        --bind 'alt-up:execute-silent(tmux previous-window -t {})+refresh-preview' \
        --bind 'alt-down:execute-silent(tmux next-window -t {})+refresh-preview' \
)
[ $? -eq 130 ] && exit 0

tmux list-sessions -F '#{session_id} |#{session_name}|' | grep "|$SESSION_NAME|" > /dev/null
[ $? -ne 0 ] && exit 0

tmux switch-client -t "$SESSION_NAME"
