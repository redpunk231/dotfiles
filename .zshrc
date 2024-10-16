export ZSH="/$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(
    git
    docker
    docker-compose
    fzf
    #zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source ~/.profile_env
for src in ~/.zshrc.d/*; do
    source "$src"
done

zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

PROMPT="$PROMPT› "


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
source $HOME/.cargo/env

function update-dotfiles() {
    if [ "$(pwd)" != "$HOME/.dotfiles" ]; then
        echo 'current path is not path with dotfiles...'
        return 1
    fi

    stow -Rv .
}
