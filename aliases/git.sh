#!/usr/bin/env bash

alias lzg="lazygit"
alias git="LANG=en_US.UTF-8 git"
alias glg="git log --graph"
alias gundo="git reset --soft HEAD^"
alias gdob="git branch -vv | grep ': gone' | cut -d ' ' -f 3 | xargs git branch -D"
alias gdm="git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d; git remote -v update -p"
alias gcontributors="git shortlog --summary --numbered --no-merges"
alias gcy="git branch --show-current | tr -d '\n' | xclip -sel clip"
alias gcob="git branch -a | sed \"s/remotes\/origin\///g\" | sed \"s/\s//g\" | sed \"s/*//\" | sort | uniq | fzf | xargs --no-run-if-empty git checkout"
alias grho="git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias glg='git log --graph'
alias gst='git status --short'

function gist() {
    (&>/dev/null xdg-open "https://gist.github.com/vnea" &)
}

function vnea() {
    (&>/dev/null xdg-open "https://github.com/vnea" &)
}

function zd() {
  preview="git diff $* --color=always -- {-1} | diff-so-fancy"
  git diff "$@" --name-only | fzf -m --ansi --preview-window=right:70% --preview "$preview"
}

function zdm() {
  zd main
}

function gdm {
  git diff main
}

function gsquash {
  number_of_commits_to_squash=${1}
  if [ -z "$1" ]
  then
    echo "Usage: $0 <number_of_commits_to_squash>"
    return
  fi

  git reset --soft HEAD~"${number_of_commits_to_squash}" && git commit --edit --message "$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
}

