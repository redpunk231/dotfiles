#!/bin/bash
source ~/.profile_env
SELF=$(realpath $0)

[[ -z "$TMUX" ]] && exit 1

sessions_list() {
    tmux list-sessions -F '#{session_activity}:#{session_name}' | \
        sort -r | \
        awk -F ':' '{print $2}'
}

session_preview() {
    tmux list-windows -t $1 -F '#{window_active} #{window_name}' | \
        sed 's/^1/*/g' | \
        sed 's/^0/\ /g'
}

session_new() {
    NAME=$(echo '' | \
        $FZF_PATH/fzf-tmux -p 20%,6% \
            --info=hidden \
            --no-separator \
            --pointer=' ' \
            --print-query \
            --prompt='create session: '\
    )
    CODE=$?

    if [ $CODE -eq 0 ] || [ $CODE -eq 1 ]; then
        if [ "$NAME" == "" ]; then
            NAME=$(uuidgen)
        fi

        NAME=$(echo $NAME | sed 's/\ /_/g')
        TMUX='' tmux new-session -d -s $NAME -c "~/"
        tmux switch-client -t $NAME
    fi
}

session_rename() {
    [[ "$1" == "main" ]] && return
    tmux list-sessions -F '#{session_name}' | grep "^$1$" > /dev/null || return

    NAME=$(echo '' | \
        $FZF_PATH/fzf-tmux -p 20%,6% \
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

window_new() {
    DIR="~/"
    SESSION_ID=$(tmux display-message -p '#{session_id}')

    if [ "$SESSION_ID" != '$0' ]; then
        if [ /tmp/tmux/PWD_$SESSION_ID ]; then
            DIR="$(cat /tmp/tmux/PWD_$SESSION_ID)"
        fi
    fi

    tmux new-window -a -c "$DIR"
}

window_rename() {
    CUR_NAME="$(tmux display-message -p '#W')"
    NAME=$(\
        echo '' | $FZF_PATH/fzf-tmux -p 20%,6% \
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


window_move_to_session() {
    SESSIONS=($(sessions_list))
    if [ ${#SESSIONS[*]} -eq 1 ]; then
        exit 0
    fi

    if [ "$1" == "next" ]; then
        SESSION_NAME=${SESSIONS[1]}
    elif [ "$1" == "prev" ]; then
        SESSION_NAME=${SESSIONS[-1]}
    else
        exit 1
    fi

    tmux move-window -t $SESSION_NAME -a
}

main() {
    if [ -z "$TMUX_SESSION_MANAGER" ]; then
        export TMUX_SESSION_MANAGER=$$
    fi

    SESSION_CURRENT=$(\
        tmux list-sessions -F '#{session_activity}:#{session_name}' | \
        sort -r | \
        head -1 | \
        awk -F ':' '{print $2}'\
    )

    FZF_DEFAULT_COMMAND="$SELF --session-list"

    BREAK=0
    while [ $BREAK -eq 0 ]; do
        FZF_RESULT=$(\
            $FZF_DEFAULT_COMMAND | \
            $FZF_PATH/fzf-tmux --cycle -p 20%,99% -x 10000 --info=hidden --print-query \
                --preview "$SELF --session-preview {}" \
                --preview-window up,33%,border-none \
                --bind 'focus:execute-silent(tmux switch-client -t {})' \
                --bind "zero:execute-silent(tmux switch-client -t $SESSION_CURRENT)" \
                --bind "esc:execute-silent(tmux switch-client -t $SESSION_CURRENT)+abort" \
                --bind 'alt-j:execute-silent(tmux previous-window -t {})+refresh-preview' \
                --bind 'alt-k:execute-silent(tmux next-window -t {})+refresh-preview' \
                --bind "alt-d:execute-silent(tmux kill-session -t {})+reload($FZF_DEFAULT_COMMAND)" \
                --bind "ctrl-alt-j:execute-silent($SELF --window-move prev)+up+reload($FZF_DEFAULT_COMMAND)" \
                --bind "ctrl-alt-k:execute-silent($SELF --window-move next)+down+reload($FZF_DEFAULT_COMMAND)" \
                --bind "alt-enter:clear-query+put(#create_session)+accept-or-print-query" \
                --bind "alt-r:put(#rename_session)+accept-or-print-query" \
        )
        if [ $? -ne 130 ]; then
            echo "$FZF_RESULT" | grep '^#create_session$' > /dev/null
            if [ $? -eq 0 ]; then
                session_new
                break
            fi

            echo "$FZF_RESULT" | grep '^#rename_session' > /dev/null
            if [ $? -eq 0 ]; then
                NEW_NAME=$(echo "$FZF_RESULT" | sed 's/#rename_session//g' | xargs)
                session_rename "$NEW_NAME"
                continue
            fi

        fi
        BREAK=1
    done
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

        --session-preview)
            session_preview $2
            exit 0
        ;;

        --session-rename)
            session_rename $2
            exit 0
        ;;

        --window-new)
            window_new
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

        --window-move)
            window_move_to_session $2
            exit 0
        ;;
    esac
done

main
