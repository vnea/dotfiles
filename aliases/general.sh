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
alias cat="mcat"

# For copying commands from the web, source: https://www.30secondsofcode.org/articles/s/bash-alias-dollar-sign
alias '$'=""

function def() {
  function_name="$1"
  declare -f "$function_name" | pygmentize
}

# shellcheck disable=SC2164
function goto() {
  workspace_folder=~/workspace

  custom_folders=(
    "$HOME/Documents/Obsidian Vault"
    "$HOME/dotfiles"
    "$HOME/Downloads"
  )

  folder_bookmarks=$(
    fd . $workspace_folder --type directory --max-depth 1 |
    sed -E 's/(.+workspace\/)(.+)\//\2/g' |
    \cat - <(echo "$workspace_folder") |
    \cat - <(printf '%s\n' "${custom_folders[@]}") |
    sort
  )

  selected_folder_bookmark=$(echo "$folder_bookmarks" | fzf)
  if [ -z "$selected_folder_bookmark" ]; then
      return
  fi

  if [[ "$selected_folder_bookmark" == /* ]]; then
    cd "$selected_folder_bookmark"
  else
    cd "$workspace_folder/$selected_folder_bookmark"
  fi

  tmux rename-window "$(basename "$(pwd)")"
}
