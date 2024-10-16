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

# PIP stuff
alias pip='noglob pip'
alias pip-tools-upgrade='pip install --upgrade pip-tools'
alias pip-compile='pip-compile --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking'
alias pip-compile-hash='pip-compile --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking --generate-hashes'
function pip-refresh() {
    pip-compile \
        --rebuild --quiet --annotation-style line --no-header --upgrade --resolver=backtracking \
        -o requirements.txt requirements.in \
        && pip-sync
}
