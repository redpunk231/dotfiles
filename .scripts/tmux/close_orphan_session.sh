#!/bin/bash
source ~/.profile_env

for i in $(tmux list-sessions -F '#{session_name}' | grep '#[0-9]*' | sed 's/.*#//g'); do
    tmux list-windows -F '#{window_id}' -t 'main' | sed 's/@//g' | grep "$i" > /dev/null
    if [ $? -ne 0 ]; then
        SESSION_NAME=$(tmux list-sessions -F '#{session_name}' | grep "$i$")
        YES=$(echo -e "Yes\nNo" | $FZF_PATH/fzf-tmux -p -p 13%,10% --no-info --pointer='> ' --reverse --prompt='Закрыть сессию? ')
        if [ "$YES" == "No" ]; then
            NEW_NAME=$(echo $SESSION_NAME | sed "s/ \?#$i//g")
            if [ "$NEW_NAME" == "" ]; then
                NEW_NAME=$(uuidgen)
            fi

            tmux rename-session -t "$SESSION_NAME" "$NEW_NAME"
        else
            tmux kill-session -t "$SESSION_NAME"
        fi
    fi
done
