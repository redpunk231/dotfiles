function python_env() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        return 0
    fi

    if [ -d .venv ]; then
        source .venv/bin/activate
        return 0
    fi

    if [ -d venv ]; then
        source venv/bin/activate
        return 0
    fi

    echo "virtual env not found"
    return 1
}
alias v='python_env'

# PIP
alias pip='noglob pip'
alias uv-update-version='uv self update'

# virtual env autoload
autoload -Uz add-zsh-hook
_venv_auto_activate() {
    if [[ -n "$VIRTUAL_ENV" && "$(dirname $VIRTUAL_ENV)" != "$(pwd)" ]]; then
        deactivate
    fi

    if [ -z "$VIRTUAL_ENV" ]; then
        if [ -d .venv ]; then
            source .venv/bin/activate
        elif [ -d venv ]; then
            source venv/bin/activate
        fi
    fi
}
add-zsh-hook chpwd _venv_auto_activate
_venv_auto_activate
