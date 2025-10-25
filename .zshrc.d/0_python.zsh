function python_env() {
    if [ "$VIRTUAL_ENV" != "" ]; then
        deactivate
        return 0
    fi

    if [ -f "venv/bin/activate" ]; then
        source venv/bin/activate
        return 0
    fi

    echo "virtual env not found"
    return 1
}
alias v='python_env'

# PIP
alias pip='noglob pip'

# UV
alias upip='uv pip'
alias uvenv38='uv venv --python 3.8 venv'
alias uvenv39='uv venv --python 3.9 venv'
alias uvenv310='uv venv --python 3.10 venv'
alias uvenv311='uv venv --python 3.11 venv'
alias uvenv312='uv venv --python 3.12 venv'
alias uvenv313='uv venv --python 3.13 venv'
alias uv-update-version='uv self update'

# virtual env autoload
autoload -Uz add-zsh-hook
_venv_auto_activate() {
    if [[ -d venv && -n "$VIRTUAL_ENV" && "$VIRTUAL_ENV" != "$(pwd)/venv" ]]; then
        deactivate
    elif [[ -d venv && -z "$VIRTUAL_ENV" ]]; then
        source venv/bin/activate
    elif [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
}
add-zsh-hook chpwd _venv_auto_activate
_venv_auto_activate
