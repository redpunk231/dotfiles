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
alias uv-update-version='uv self update'

alias uvenv38='uv venv --python 3.8 venv'
alias uvenv39='uv venv --python 3.9 venv'
alias uvenv310='uv venv --python 3.10 venv'
alias uvenv311='uv venv --python 3.11 venv'
alias uvenv312='uv venv --python 3.12 venv'
alias uvenv313='uv venv --python 3.13 venv'

alias upip='uv pip'
