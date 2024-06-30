#!/bin/bash

PID=/tmp/tmux.pid

WIN=$(wmctrl -lp | grep $(cat $PID))
if [ $? -eq 0 ]; then
    wmctrl -ia $(echo "$WIN" | awk '{print $1}')
    exit 0
fi

SESSIONS=($(tmux list-sessions -F '#S'))
if [ ${#SESSIONS[@]} -eq 0 ]; then
    tmux new -d -s main
fi

# gnome-terminal --maximize -- /home/redpunk/.scripts/run_tmux.sh
alacritty \
    -o 'window.decorations="none"' \
    -o 'window.startup_mode="Maximized"' \
    -t tmux -e tmux attach -t main &
echo $! > $PID
