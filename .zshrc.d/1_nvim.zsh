DIR_UPDATE_TMP="$HOME/.nvim_releases"
DIR_OPT='/opt'
DIR_OPT_NVIM="$DIR_OPT/nvim-linux-x86_64"
URL_DISTRIB='https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz'
FILE_DISTRIB='nvim.tar.gz'

function nvim_upgrade() {
    DIR=$PWD
    cd "$DIR_UPDATE_TMP"

    echo 'download latest neovim release...'
    curl --silent -L "$URL_DISTRIB" -o "$FILE_DISTRIB"
    if [ $? -ne 0 ]; then
        echo 'download latest neovim release failed...'
        return 1
    fi 

    echo 'check sum...'
    md5sum -c --quiet .md5
    if [ $? -eq 0 ]; then
        echo "upgrade not required..."
        cd $DIR
        return 0
    fi

    echo 'started upgrading...'
    sudo rm -rf "$DIR_OPT_NVIM"
    sudo tar -C "$DIR_OPT" -xzf "$FILE_DISTRIB"

    md5sum "$FILE_DISTRIB" > .md5

    echo 'finished upgrading...'
    echo
    echo "$($DIR_OPT_NVIM/bin/nvim -v)"

    cd $DIR
}

alias vim='nvim'
