#!/usr/bin/env bash

if ! command -v pacman >/dev/null 2>&1
then
    return
fi

alias pc="pacman"
alias pcu="sudo pacman -Syu"
alias pcr="sudo pacman -R"
alias pcs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' --preview-window='up:50%' | xargs --no-run-if-empty --open-tty sudo pacman -S"

