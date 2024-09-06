#!/bin/bash
source ~/.profile_env
SELF=$(realpath $0)

[[ -z "$TMUX" ]] && exit 1

sessions_list() {
    tmux list-sessions -F '#{session_activity}:#{session_name}' | \
        sort -r | \
        awk -F ':' '{print $2}'
}

session_new() {
    DIR=$((echo $HOME; find ~/.code -type d -maxdepth 1) | \
        $FZF_PATH/fzf-tmux -p 25%,15% \
            --info=hidden \
            --prompt='work path: ' \
            --border-label='Create session' \
    )
    [ $? -ne 0 ] && return 0

    SESSION_NAME=$(basename $DIR)
    if [ "$DIR" == "$HOME" ]; then
        SESSION_NAME="main"
        sessions_list | grep '^main$' > /dev/null
        if [ $? -eq 0 ]; then
            SESSION_NAME=$(echo '' | \
                $FZF_PATH/fzf-tmux -p 25%,6% \
                    --info=hidden \
                    --no-separator \
                    --pointer=' ' \
                    --print-query \
                    --prompt='name: '\
                    --border-label='Create session' \
                    --query="$1" \
            )
            [ $? -ne 1 ] && return 0
            if [ "$SESSION_NAME" == "" ]; then
                SESSION_NAME="main_$(date +%Y%m%d_%H%M%S)"
            fi
        fi
    fi
    SESSION_NAME=$(echo "$SESSION_NAME" | sed 's/\ /_/g' | sed 's/\.//g')

    TMUX='' tmux new-session -d -s "$SESSION_NAME" -c "$DIR"
    tmux switch-client -t "$SESSION_NAME"
}

session_rename() {
    sessions_list | grep "^$1$" > /dev/null || return

    NAME=$(echo '' | \
        $FZF_PATH/fzf-tmux -p 25%,6% \
            --info=hidden \
            --no-separator \
            --pointer=' ' \
            --print-query \
            --prompt='rename session: '\
            --query="$1"
    )
    CODE=$?

    if [ $CODE -eq 0 ] || [ $CODE -eq 1 ]; then
        if [ "$NAME" != "" ] && [ "$NAME" != "main" ]; then
            NAME=$(echo $NAME | sed 's/\ /_/g')
            TMUX='' tmux rename-session -t "$1" "$NAME"
        fi
    fi
}

window_rename() {
    CUR_NAME="$(tmux display-message -p '#W')"
    NAME=$(\
        echo '' | $FZF_PATH/fzf-tmux -p 25%,6% \
            --info=hidden \
            --no-separator \
            --pointer=' ' \
            --print-query \
            --prompt='rename window: '\
            -q "$CUR_NAME"\
    )
    if [ $? -ne 130 ] && [ "$NAME" != "" ] && [ "$NAME" != "$CUR_NAME" ]; then
        tmux rename-window "$NAME"
    fi
}

window_popup() {
    PWD=$(\
        tmux list-panes -F "#{pane_active}:#{pane_current_path}" | \
        grep '^1' | \
        sed 's/^1://g'\
    )
    tmux display-popup -h 35% -w 65% -b rounded -d $PWD -S fg=colour241 -E zsh
}

main() {
    if [ -z "$TMUX_SESSION_MANAGER" ]; then
        export TMUX_SESSION_MANAGER=$$
    fi

    SESSION_PREVIEW_CMD="tmux capture-pane -ep -t {}"
    FZF_DEFAULT_COMMAND="$SELF --session-list"
    FZF_RESULT=$(\
        $FZF_DEFAULT_COMMAND | \
        $FZF_PATH/fzf-tmux \
            --cycle \
            -p 95%,80% \
            --preview="$SESSION_PREVIEW_CMD" \
            --preview-window=top,90%,wrap \
            --info=hidden \
            --border-label='Sessions' \
            --bind "alt-d:execute-silent(tmux kill-session -t {})+reload($FZF_DEFAULT_COMMAND)" \
    )
    [ $? -ne 0 ] && return 0
    tmux switch-client -t $FZF_RESULT
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --session-new)
            session_new
            exit 0
        ;;

        --session-list)
            sessions_list
            exit 0
        ;;

        --session-rename)
            session_rename $2
            exit 0
        ;;

        --window-rename)
            window_rename
            exit 0
        ;;

        --window-popup)
            window_popup
            exit 0
        ;;
    esac
done

main
