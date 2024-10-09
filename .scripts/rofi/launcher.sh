#!/bin/bash

### Variables ###
THEME="$HOME/.dotfiles/.scripts/rofi/theme.rasi"
CACHE="$HOME/.cache/rofi"

### Run ###
rofi \
    -show drun window \
    -theme $THEME \
    -cache-dir $CACHE \
    -sorting-method fzf \
    -matching normal
