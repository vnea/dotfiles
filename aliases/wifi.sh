#!/usr/bin/env bash

[ -x "$(command -v nmtui)" ] || return

alias wifi="nmtui"
