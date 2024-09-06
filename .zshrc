export ZSH="/$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(
    git
    git-auto-fetch
    docker
    docker-compose
    fzf
    #zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source ~/.profile_env

zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

PROMPT="$PROMPT› "
# export FZF_DEFAULT_COMMAND='fdfind --type f --exclude="*__pycache__*" --exclude="*.pyc"'

function tmux_rename() {
    NAME=$1
    [ "$TMUX" = "" ] || tmux rename-window $NAME
}


compdef _work work
_work() {
    #compadd $(echo "
        #example
    #")

    compadd $(find /home/roman/.code -maxdepth 1 -mindepth 1 -type d -printf "%f\n")
}
function work() {
    WORK_PATH=~/.code
    SAVE_PATH=$(pwd)

    if [ ! -d $WORK_PATH/$1 ]; then
        echo "project \"$1\" not exists"
        return 1
    fi
    cd $WORK_PATH/$1

    if [ "$VIRTUAL_ENV" = "" ]; then
        if [ -f "venv/bin/activate" ]; then
            source venv/bin/activate
        else
            echo "virtual env not found"
            return 1
        fi
    fi

    #python_env
    if [ $? -ne 0 ]; then
        echo "env error"
        return 1
    fi

    if [ "$2" = "" ]; then
        PROJECT_NAME=$1
        if [[ "$1" == "oem-x86-automated-testing" ]]; then
            PROJECT_NAME="oem_x86"
        elif [[ "$1" == "service-oem-network-scanner" ]]; then
            PROJECT_NAME="oem_scanner"
        elif [[ "$1" == "tatlin-automated-testing" ]]; then
            PROJECT_NAME="tatlin_testing"
        elif [[ "$1" == "tatlin-disk-configuration" ]]; then
            PROJECT_NAME="tatlin_conf"
        fi

        tmux_rename $PROJECT_NAME
        nvim
        #deactivate
        #cd $SAVE_PATH
        return 0
    fi
}

function project() {
    PROJECT_PATH=$(pwd)

    if [ ! -f "venv/bin/activate" ]; then
        echo "virtual env not found"
        return 1
    fi

    tmux rename-window 'code'

    source venv/bin/activate
    nvim
}

function dexe() {
    tmux_rename "docker $1"
    docker exec -it $(docker ps | grep $1 | awk '{print $1}') /bin/bash
}

function nvim_config() {
    SAVE_PATH=$(pwd)
    cd ~/.config/nvim
    tmux_rename "nvim conf"
    nvim
    cd $SAVE_PATH
}

function python_env() {
    if [ "$VIRTUAL_ENV" = "" ]; then
        if [ -f "venv/bin/activate" ]; then
            source venv/bin/activate
        else
            echo "virtual env not found"
            return 1
        fi

    else
        deactivate
    fi

    return 0
}
alias v='python_env'

compdef _tmp_project tmp_project
_tmp_project() {
    compadd $(find $HOME/.code_tmp -maxdepth 1 -mindepth 1 -type d -printf "%f\n")
}
function tmp_project() {
    SAVE_PATH=$(pwd)
    PROJECT_PATH=$HOME/.code_tmp/$1

    mkdir -p $PROJECT_PATH
    cd $PROJECT_PATH

    if [ ! -d "$PROJECT_PATH/venv" ]; then
        python3 -m venv venv
        touch main.py
        touch requirements.txt
    fi


    echo $(date +'%Y-%m-%d %H:%M:%S') > .last_used

    python_env

    if [ "$2" = "shell" ]; then
        return 0
    fi

    if [ "$2" = "docker" ]; then
        if [ ! -f "$PROJECT_PATH/Dockerfile" ]; then
            echo 'Dockerfile not found'
            return 1
        fi

        docker build -t $1 . && docker run --rm -p 8080:8080 -v $PROJECT_PATH/.env:/app/.env -it $1
        return 0
    fi

    tmux_rename "$1 ♲"
    nvim main.py
    deactivate
    cd $SAVE_PATH
}

alias pip='noglob pip'
alias vim='nvim'

alias pip-tools-upgrade='pip install --upgrade pip-tools'
alias pip-compile='pip-compile --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking'
alias pip-compile-hash='pip-compile --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking --generate-hashes'

function pip-refresh() {
    pip-compile --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking -o requirements.txt requirements.in && pip-sync
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
