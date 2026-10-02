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

if command -v wt &> /dev/null; then
  function gcob() {
    local branch
    branch=$(git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g; s/^+//g' | sort | uniq | fzf) || return

    if [ -n "$branch" ]; then
      wt switch "$branch"
      tmux rename-window "$(basename "$PWD")"
    fi
  }

  function gbd() {
    local branch
    branch=$(git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g; s/^+//g' | sort | uniq | fzf) || return

    if [ -n "$branch" ]; then
      wt remove "$branch"
      tmux rename-window "$(basename "$PWD")"
    fi
  }

  function gco() {
    local branch
    branch=$1

    wt switch $1
    tmux rename-window "$(basename "$PWD")"
  }

  alias gco-='wt switch - && tmux rename-window "$(basename "$PWD")"'

  function gcom() {
    wt switch master 2>/dev/null || wt switch main
    tmux rename-window "$(basename "$PWD")"
  }

  function gcomup() {
    wt switch master 2>/dev/null || wt switch main
    git pull
    tmux rename-window "$(basename "$PWD")"
  }

  function gcb() {
    local branch
    branch=$1

    wt switch --create $1
    tmux rename-window "$(basename "$PWD")"
  }

  function grm() {
    local branch
    branch=$1

    wt remove $1
    tmux rename-window "$(basename "$PWD")"
  }

  function gclean() {
    local branches_raw
    branches_raw=$(wt list --format=json | jq -r '.items[] | select(.default_branch.integration != null) | .branch')
    if [[ -z "$branches_raw" ]]; then
      echo "No merged worktrees to clean"
    else
      local -a branches
      branches=("${(@f)branches_raw}")
      wt remove -y "${branches[@]}"
    fi
    git remote -v update -p
  }
else
  alias gcob="git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g' | sort | uniq | fzf | xargs --no-run-if-empty git checkout"
  alias gbd="git branch -a | sed 's/remotes\/origin\///g; s/[[:space:]]//g; s/\*//g' | sort | uniq | fzf | xargs --no-run-if-empty git branch -D"
  alias gco="wt switch"
  alias gco-="git checkout -"
  alias gcom="git checkout master 2>/dev/null || git checkout main"
  alias gcomup="(git checkout master 2>/dev/null || git checkout main) && git pull"
  alias gcb="git checkout -b"
  alias grm="git branch -D"
  alias gclean="git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d; git remote -v update -p"
fi

# Cherry pick
alias gcp="git cherry-pick"

# Clean
alias greset_repo="git clean -fxd"

# Clone
alias gc="git clone"

# Commit
alias gca="git commit --amend"
alias gcam="git add --all && git commit --message"
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gcmsg="git commit --message"

# Diff
alias gd="git diff"
alias gdca="git diff --cached"
alias gdcw="git diff --cached --word-diff"
alias gdcw="git diff --cached --word-diff"

# Fetch
alias gf="git fetch"

# Log
alias glg="git log --graph --date=format-local:'%a %d/%m/%Y' --pretty=format:'%C(red)%h%Creset -%C(auto)%d%Creset %C(white)%s%Creset %C(green)(%ad, %cr)%Creset %C(bold blue)<%an>%Creset'"
alias glc='git log --pretty=format:"%s" | fzf --reverse | pbcopy'

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
alias grbi="git rebase --interactive"

# Reset
alias gr="git reset"
alias grhh="git add --all && git reset --hard"
alias grho="git add --all && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias gundo="git reset --soft HEAD^"

# Status
alias gst="git status --short"

# Others
alias gcontributors="git shortlog --summary --numbered --no-merges"
alias lzg="lazygit"
alias gg="git grep --textconv"

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

function gcyss() {
    local branch
    branch=$(git rev-parse --short HEAD | tr -d '\n')
    if [[ "$(uname)" == "Darwin" ]]; then
        echo -n "$branch" | pbcopy
    else
        echo -n "$branch" | xclip -sel clip
    fi
}
