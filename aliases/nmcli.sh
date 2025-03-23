#!/usr/bin/env bash

if ! command -v nmcli >/dev/null 2>&1
then
    return
fi

function vu {
    nmcli connection show | rg wireguard | awk '{print $1}' | fzf | xargs --no-run-if-empty nmcli connection up
}

function vd {
    nmcli connection show --active | rg wireguard | awk '{print $1}' | xargs --no-run-if-empty nmcli connection down
}
