#!/usr/bin/env bash

alias lzg="lazygit"
alias git="LANG=en_US.UTF-8 git"
alias glg="git log --graph"

# Undo last commit
alias gundo="git reset --soft HEAD^"

# Delete outdated branches
alias gdob="git branch -vv | grep ': gone' | cut -d ' ' -f 3 | xargs git branch -D"

# Remove branches that have already been merged with default branch
alias gdm="git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d; git remote -v update -p"

# List contributors
alias gcontributors="git shortlog --summary --numbered --no-merges"

# Copy current branch in clipboard
alias gcy="git branch --show-current | tr -d '\n' | xclip -sel clip"

# Select branch with fzf
alias gcob="git branch -a | sed \"s/remotes\/origin\///g\" | sed \"s/\s//g\" | sed \"s/*//\" | sort | uniq | fzf | xargs --no-run-if-empty git checkout"

# Reset current work to current origin branch
alias grho="git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"

function gist() {
    (&>/dev/null xdg-open "https://gist.github.com/vnea" &)
}

function vnea() {
    (&>/dev/null xdg-open "https://github.com/vnea" &)
}

# Fzf diff
function zd() {
  preview="git diff $* --color=always -- {-1} | diff-so-fancy"
  git diff "$@" --name-only | fzf -m --ansi --preview-window=right:70% --preview "$preview"
}

# Fzf diff with main
function zdm() {
  zd main
}

# Classic diff with main
function gdm {
  git diff main
}

# Squash N last commits
function gsquash {
  number_of_commits_to_squash=${1}
  if [ -z "$1" ]
  then
    echo "Usage: $0 <number_of_commits_to_squash>"
    return
  fi

  git reset --soft HEAD~"${number_of_commits_to_squash}" && git commit --edit --message "$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
}
