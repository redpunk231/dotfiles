TMP_PROJECTS_PATH="$HOME/.code_tmp"

function project() {
    python_env || return 1
    tmux_rename_window 'code'
    nvim
}

compdef _tmp_project tmp_project
_tmp_project() { compadd $(find $TMP_PROJECTS_PATH -maxdepth 1 -mindepth 1 -type d -printf "%f\n")}

function tmp_project() {
    SAVE_PATH=$(pwd)
    PROJECT_PATH=$HOME/.code_tmp/$1

    mkdir -p $PROJECT_PATH
    cd $PROJECT_PATH

    if [ ! -d "$PROJECT_PATH/venv" ]; then
        uv venv venv
        touch main.py
        touch requirements.txt
    fi

    echo $(date +'%Y-%m-%d %H:%M:%S') > .last_used

    python_env || return 1
    tmux_rename_window "$1 ♲"

    nvim main.py

    deactivate
    cd $SAVE_PATH
}

alias pr='project'
