#!/usr/bin/env bash

readonly ALACRITTY_CONFIG_FILE=~/dotfiles/alacritty/.config/alacritty/alacritty.yml

readonly theme_dark=github_dark_default.yml
readonly theme_light=github_light_default.yml

toggleTheme() {
    readonly from_theme="${1}"
    readonly to_theme="${2}"
    sed -i "s/${from_theme}/${to_theme}/" "${ALACRITTY_CONFIG_FILE}"
}

if rg --fixed-strings --quiet "${theme_dark}" "${ALACRITTY_CONFIG_FILE}"; then
    toggleTheme "${theme_dark}" "${theme_light}"
else
    toggleTheme "${theme_light}" "${theme_dark}"
fi

