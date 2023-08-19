#!/usr/bin/env bash

alias rf="source ~/.zshrc"
alias ez="nvim ~/.zshrc"
alias et="nvim ~/.config/tmux/tmux.conf"
alias explorer="nemo . &"
alias lx="exa --long --group --header --git --icons"
alias lxa="lx --all"
alias grep="grep --color=auto"
alias df="duf"
alias '$'=''

function gmail() {
  (&>/dev/null xdg-open "https://mail.google.com" &)
}

function gcal() {
  (&>/dev/null xdg-open "https://calendar.google.com/calendar/u/1/r" &)
}

function def() {
  function_name="$1"
  declare -f "$function_name" | pygmentize
}
