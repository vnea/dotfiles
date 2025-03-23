#!/usr/bin/env bash

alias a="alias"
alias rf="source ~/.zshenv && source ~/.zshrc"
alias ez="nvim ~/.zshrc"
alias ezv="nvim ~/.zshenv"
alias et="nvim ~/.config/tmux/tmux.conf"
alias explorer="nemo . &"
alias lx="eza --long --group --header --git --icons=always"
alias lxa="lx --all"
alias grep="grep --color=auto"
alias df="duf"
alias du="dust"
alias z="fg"
alias cd-="cd -"

# For copying commands from the web, source: https://www.30secondsofcode.org/articles/s/bash-alias-dollar-sign
alias '$'=''

function _open_link() {
    link=$1

    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$link" &>/dev/null
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open "$link" &>/dev/null
    fi
}

function gmail() {
  _open_link "https://mail.google.com"
}

function gcal() {
  _open_link "https://calendar.google.com/calendar/u/1/r"
}

function def() {
  function_name="$1"
  declare -f "$function_name" | pygmentize
}

function goto() {
  workspace_folder=~/workspace
  dotfiles_folder=~/dotfiles

  projects=$(
    fd . $workspace_folder --type directory --max-depth 1 |
    sed -E 's/(.+workspace\/)(.+)\//\2/g' |
    cat - <(echo $workspace_folder) |
    cat - <(echo $dotfiles_folder) |
    sort
  )
  selected_project=$(echo $projects | fzf)
  if [ -z "$selected_project" ]; then
      return
  fi

  if [ "$selected_project" = "$dotfiles_folder" ]; then
      cd $dotfiles_folder
  elif [ "$selected_project" = "$workspace_folder" ]; then
      cd $workspace_folder
  else
      cd "$workspace_folder/$selected_project"
  fi

  tmux rename-window "$(basename $(pwd))"
}
