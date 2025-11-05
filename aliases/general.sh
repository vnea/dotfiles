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
  dotfiles_folder=~/dotfiles
  notes_folder=~/notes

  projects=$(
    fd . $workspace_folder --type directory --max-depth 1 |
    sed -E 's/(.+workspace\/)(.+)\//\2/g' |
    \cat - <(echo $workspace_folder) |
    \cat - <(echo $dotfiles_folder) |
    \cat - <(echo $notes_folder) |
    sort
  )

  selected_project=$(echo "$projects" | fzf)
  if [ -z "$selected_project" ]; then
      return
  fi

  case "$selected_project" in
      "$workspace_folder")
          cd "$workspace_folder"
          ;;
      "$dotfiles_folder")
          cd "$dotfiles_folder"
          ;;
      "$notes_folder")
          cd "$notes_folder"
          ;;
      *)
          cd "$workspace_folder/$selected_project"
          ;;
  esac

  tmux rename-window "$(basename "$(pwd)")"
}
