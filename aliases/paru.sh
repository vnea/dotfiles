#!/usr/bin/env bash

# Update all packages
alias pru="paru -Sua"

# Remove temprorary installed dependencies needed for compilation
alias prc="paru --clean"

# Search a package with fzf and install it, adapted from: https://github.com/joehillen/paruz/blob/master/paruz
alias prs="paru --color=always -Sl | sed -e 's: :/:; s/ unknown-version//' | fzf --multi --ansi --preview='paru --color=always -Si {1}' --preview-window='up:50%' | xargs --no-run-if-empty --open-tty paru -S --cleanafter"
