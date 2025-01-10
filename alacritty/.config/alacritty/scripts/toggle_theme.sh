#!/usr/bin/env bash

readonly alacritty_config_file=~/dotfiles/alacritty/.config/alacritty/alacritty.toml

readonly theme_dark=github_dark_default.toml
readonly theme_light=github_light_default.toml

toggleTheme() {
    readonly from_theme="${1}"
    readonly to_theme="${2}"
    sd "${from_theme}" "${to_theme}" "${alacritty_config_file}"
}

if rg --fixed-strings --quiet "${theme_dark}" "${alacritty_config_file}"; then
    toggleTheme "${theme_dark}" "${theme_light}"
else
    toggleTheme "${theme_light}" "${theme_dark}"
fi

