#!/usr/bin/env bash

function _open_link() {
    link=$1

    if [[ "$(uname)" == "Darwin" ]]; then
        open "$link" &>/dev/null
    else
        xdg-open "$link" &>/dev/null
    fi
}
