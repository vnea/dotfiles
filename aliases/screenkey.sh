#!/usr/bin/env bash

[ -x "$(command -v screenkey)" ] || return

alias sk="screenkey"
alias skk="pkill -f screenkey"

