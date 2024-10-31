function tmux_rename_window() {
    [ "$TMUX" = "" ] || tmux rename-window "$1"
}

function tmux_sessions_list() {
    tmux list-sessions -F '#{session_activity}:#{session_name}' | \
        sort -r | \
        awk -F ':' '{print $2}'
}

function tmux_session_there() {
    SESSION_NAME=$(basename $PWD | sed 's/\ /_/g' | sed 's/\.//g')
    tmux_sessions_list | grep "$SESSION_NAME" > /dev/null
    if [ $? -eq 0 ]; then
        echo 'session already exists'
        return 1
    fi

    TMUX='' tmux new-session -d -s "$SESSION_NAME" -c "$PWD"
    tmux switch-client -t "$SESSION_NAME"
}

alias tst='tmux_session_there'
