#!/usr/bin/env bash

alias rf="source ~/.zshenv && source ~/.zshrc"
alias ez="nvim ~/.zshrc"
alias ezv="nvim ~/.zshenv"
alias et="nvim ~/.config/tmux/tmux.conf"
alias explorer="nemo . &"
alias lx="eza --long --group --header --git --icons=always $@"
alias lxa="lx --all"
alias grep="grep --color=auto"
alias df="duf"
alias du="dust"

# For copying commands from the web, source: https://www.30secondsofcode.org/articles/s/bash-alias-dollar-sign
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

function goto() {
  workspace_folder=~/workspace
  dotfiles_folder=~/dotfiles

  projects=$(fd . $workspace_folder --type directory --max-depth 2 | sed -E 's/(.+workspace\/)(.+)\//\2/g' | cat - <(echo $dotfiles_folder) | sort)
  selected_project=$(echo $projects | fzf)
  if [ -z "$selected_project" ]; then
      return
  fi

  if [ "$selected_project" = "$dotfiles_folder" ]; then
      cd $dotfiles_folder
  else
      cd "$workspace_folder/$selected_project"
  fi

  tmux rename-window "`basename $(pwd)`"
}

