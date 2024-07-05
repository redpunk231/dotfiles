#!/bin/bash
source ~/.profile_env

PWD=$(tmux list-panes -F "#{pane_active}:#{pane_current_path}" | grep '^1' | sed 's/^1://g')
tmux display-popup -h 35% -w 65% -b rounded -d $PWD -S fg=colour241 -E zsh
