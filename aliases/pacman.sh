#!/usr/bin/env bash

alias pc="pacman"

# Update all packages
alias pcu="sudo pacman -Syu"

# Remove a package
alias pcr="sudo pacman -R"

# Search a package with fzf and install it
alias pcs="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' --preview-window='up:50%' | xargs --no-run-if-empty --open-tty sudo pacman -S"
