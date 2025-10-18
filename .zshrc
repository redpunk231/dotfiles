# Settings for "oh-my-zsh" framework
export ZSH="/$HOME/.oh-my-zsh"
ZSH_THEME="simple"
plugins=(
    git
    docker
    docker-compose
    fzf
    uv
    kitty
)
source $ZSH/oh-my-zsh.sh

zstyle ":completion:*:commands" rehash 1
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes


# load zshrc configs
for src in ~/.zshrc.d/*; do
    source "$src"
done
