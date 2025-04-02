#!/usr/bin/env bash

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

# To check for more aliases: "cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep alias | fzf"

# General
alias git="LANG=en_US.UTF-8 git"

# Add
alias ga="git add"
alias gaa="git add --all"

# Branch
alias gcob="git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g' | sort | uniq | fzf | xargs --no-run-if-empty git checkout"
alias gco="git checkout"
alias gco-="git checkout -"
alias gcom="git checkout master 2>/dev/null || git checkout main"
alias gcomup="(git checkout master 2>/dev/null || git checkout main) && git pull"
alias gcb="git checkout -b"
alias grm="git checkout -D"

# Cherry pick
alias gcp="git cherry-pick"

# Clean
alias gdob="git branch -vv | grep ': gone' | cut -d ' ' -f 3 | xargs git branch -D"
alias gdm="git branch --merged | grep -v '\\*' | xargs -n 1 git branch -d; git remote -v update -p"
alias greset_repo="git clean -fxd"

# Commit
alias gcam="git add --all && git commit --message"
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gcmsg="git commit --message"

# Diff
alias gd="git diff"
alias gdca="git diff --cached"
alias gdcw="git diff --cached --word-diff"
alias gdcw="git diff --cached --word-diff"

# Log
alias glg="git log --graph"

# Log
alias glg="git log --graph"

# Pull
alias gup="git pull --rebase --prune"
alias gcan!="git commit --verbose --all --no-edit --amend"

# Push
alias gp="git push"
alias gpf="git push --force-with-lease --force-if-includes"

# Rebase
alias grb='git rebase'
alias grbm="git rebase master 2>/dev/null || git rebase main"
alias grbc="git rebase --continue"
alias grba="git rebase --abort"

# Reset
alias grhh="git reset --hard"
alias grho="git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias gundo="git reset --soft HEAD^"

# Status
alias gst="git status --short"

# Others
alias lzg="lazygit"
alias gcontributors="git shortlog --summary --numbered --no-merges"

function gist() {
    _open_link "https://gist.github.com/vnea"
}

function vnea() {
    _open_link "https://github.com/vnea"
}

function zd() {
    local preview
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
    local number_of_commits_to_squash
    number_of_commits_to_squash=${1}
    if [ -z "$1" ]
    then
        echo "Usage: $0 <number_of_commits_to_squash>"
        return
    fi

    git reset --soft HEAD~"${number_of_commits_to_squash}" && git commit --edit --message "$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
}

function gcy() {
    local branch
    branch=$(git branch --show-current | tr -d '\n')
    if [[ "$(uname)" == "Darwin" ]]; then
        echo -n "$branch" | pbcopy
    else
        echo -n "$branch" | xclip -sel clip
    fi
}
