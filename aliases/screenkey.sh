#!/usr/bin/env bash

if ! command -v screenkey >/dev/null 2>&1
then
    return
fi

alias sk="screenkey"
alias skk="pkill -f screenkey"

