function tmux_rename_window() {
    [ "$TMUX" = "" ] || tmux rename-window "$1"
}
