#!/usr/bin/env bash

if ! command -v workon >/dev/null 2>&1
then
    return
fi

alias wk="workon"
