#!/bin/bash
source ~/.profile_env

function name() {
    NAME=$(echo '' | $FZF_PATH/fzf-tmux -p -p 15%,7% --no-info --pointer=' ' --print-query)

    if [ $? -eq 130 ]; then
        return 1
    fi

    echo $NAME
}

function name_default() {
    NAME=$(name)
    [ $? -ne 0 ] && return 1

    if [ "$NAME" == "" ]; then
        NAME=$(uuidgen)
    fi

    echo $NAME
}
