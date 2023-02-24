#!/usr/bin/env bash

polybar-msg cmd quit
while pgrep --uid $UID --exact polybar >/dev/null; do sleep 1; done

polybar --config="~/.config/i3/polybar/config"
