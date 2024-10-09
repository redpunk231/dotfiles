#!/bin/bash
source ~/.profile_env
[[ -z "$TMUX" ]] && exit 1

SELF=$(realpath $0)
FZF_NAMING_OPTS='--info=hidden --no-separator --tmux=25%,5% --print-query'


sessions_list() {
    tmux list-sessions -F '#{session_activity}:#{session_name}' | \
        sort -r | \
        awk -F ':' '{print $2}'
}

session_new() {
    DIR=$((echo $HOME; find ~/.code -maxdepth 1 -type d) | \
        fzf --tmux=25%,15% \
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
                fzf $FZF_NAMING_OPTS \
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
        fzf $FZF_NAMING_OPTS \
            --prompt='rename session: '\
            --query="$1"
    )
    [ $? -ne 1 ] && return 0
    [ "$NAME" == "" ] && return 0

    NAME=$(echo $NAME | sed 's/\ /_/g')
    TMUX='' tmux rename-session -t "$1" "$NAME"
}

window_rename() {
    CUR_NAME="$(tmux display-message -p '#W' | grep -v '^\(zsh\|nvim\|less\)$')"
    NAME=$(\
        echo '' | fzf $FZF_NAMING_OPTS \
            --prompt='rename window: ' \
            -q "$CUR_NAME" \
    )
    [ $? -ne 1 ] && return 0
    [ "$NAME" == "" ] && return 0
    [ "$NAME" == "$CUR_NAME" ] && return 0

    tmux rename-window "$NAME"
}

window_popup() {
    PWD=$(\
        tmux list-panes -F "#{pane_active}:#{pane_current_path}" | \
        grep '^1' | \
        sed 's/^1://g'\
    )
    tmux display-popup \
        -h 35% -w 65% \
        -b rounded \
        -d $PWD \
        -S fg=colour241 \
        -E zsh
}

main() {
    SESSION_PREVIEW_CMD="tmux capture-pane -ep -t {}"
    FZF_DEFAULT_COMMAND="$SELF --session-list"
    FZF_RESULT=$(\
        $FZF_DEFAULT_COMMAND | \
        fzf \
            --cycle \
            --tmux=95%,80% \
            --preview="$SESSION_PREVIEW_CMD" \
            --preview-window=top,90%,wrap \
            --info=hidden \
            --border-label='Sessions' \
            --bind "alt-d:execute-silent(tmux kill-session -t {})+reload($FZF_DEFAULT_COMMAND)" \
            --bind "alt-k:up" \
            --bind "alt-j:down" \
            --bind "alt-r:execute-silent(tmux send-prefix; tmux send $)" \
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
