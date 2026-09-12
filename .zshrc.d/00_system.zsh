# Shell functions
function update-dotfiles() {
    if [ "$(pwd)" != "$HOME/.dotfiles" ]; then
        echo 'current path is not path with dotfiles...'
        return 1
    fi

    stow -Rv .
}


# Loading local profile environment variables
if [ -f ~/.local_env ]; then
    source ~/.local_env
fi


# Loading local profile functions
if [ -f ~/.local_profile ]; then
    source ~/.local_profile
fi


# Setup shell envs
PROMPT="$PROMPT› "


# Tools integrations
zoxide -V > /dev/null 2>&1
if [ $? -eq 0 ]; then
    eval "$(zoxide init zsh)"
fi
if [ -f ~/.fzf.zsh ]; then
    source $HOME/.fzf.zsh
fi
if [ -f $HOME/.cargo/env ]; then
    source $HOME/.cargo/env
fi


compdef _term-theme term-theme
_term-theme() { compadd 'dark' 'light'}

function term-theme() {
    THEME_NAME=''
    case "$1" in
        dark)
            THEME_NAME='Redpunk Dark'
        ;;
        light)
            THEME_NAME='Redpunk Light'
        ;;
    esac
    kitty +kitten themes --config-file-name kitty_local.conf --reload-in=all "$THEME_NAME"


}
