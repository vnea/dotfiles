#!/usr/bin/env bash

if ! command -v yarn >/dev/null 2>&1
then
    return
fi

alias y="yarn"
alias yi="yarn install"
