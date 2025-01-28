#!/usr/bin/env bash

alias lzg="lazygit"
alias git="LANG=en_US.UTF-8 git"
alias glg="git log --graph"
alias gundo="git reset --soft HEAD^"
alias gdob="git branch -vv | grep ': gone' | cut -d ' ' -f 3 | xargs git branch -D"
alias gdm="git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d; git remote -v update -p"
alias gcontributors="git shortlog --summary --numbered --no-merges"
alias gcy="git branch --show-current | tr -d '\n' | xclip -sel clip"
alias gcob="git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g' | sort | uniq | fzf | xargs --no-run-if-empty git checkout"
alias grho="git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias glg="git log --graph"
alias gst="git status --short"
alias gup="git pull --rebase --prune"
alias greset_repo="git clean -fxd"
alias gcom="git checkout master 2>/dev/null || git checkout main"
alias grbm="git rebase master 2>/dev/null || git rebase main"
alias gcomup="(git checkout master 2>/dev/null || git checkout main) && git pull"

function _open_link() {
    link=$1

    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$link" &>/dev/null
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        xdg-open "$link" &>/dev/null
    fi
}

function gist() {
    _open_link "https://gist.github.com/vnea"
}

function vnea() {
    _open_link "https://github.com/vnea"
}

function zd() {
  preview="git diff $* --color=always -- {-1} | diff-so-fancy"
  git diff "$@" --name-only | fzf -m --ansi --preview-window=right:70% --preview "$preview"
}

function zdm() {
  zd main
}

function gdm() {
  git diff main
}

function gsquash() {
  number_of_commits_to_squash=${1}
  if [ -z "$1" ]
  then
    echo "Usage: $0 <number_of_commits_to_squash>"
    return
  fi

  git reset --soft HEAD~"${number_of_commits_to_squash}" && git commit --edit --message "$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
}

function gclean() {
    git branch --merged | egrep -v "(^\*|master|dev|main)" | xargs --no-run-if-empty git branch -d
    git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done
}
