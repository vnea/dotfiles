#!/usr/bin/env bash

if ! command -v paru >/dev/null 2>&1
then
    return
fi

alias pru="paru -Sua"
alias prc="paru --clean"
alias prr="paru --remove"
alias prs="paru --color=always -Sl | sed -e 's: :/:; s/unknown-version//' | fzf --multi --ansi --preview='paru --color=always -Si {1}' --preview-window='up:50%' | xargs --no-run-if-empty --open-tty paru -S --cleanafter"

