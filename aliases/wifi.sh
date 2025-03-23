#!/usr/bin/env bash

if ! command -v nmtui >/dev/null 2>&1
then
    return
fi

alias wifi="nmtui"
