#!/usr/bin/env bash

setupTheme() {
    readonly current_theme_file="${1}"
    readonly new_theme_file="${2}"
    cat "$new_theme_file" > "$current_theme_file"
}

readonly theme_file="$HOME/dotfiles/alacritty/.config/alacritty/themes/theme.toml"
readonly theme_dark_file="$HOME/dotfiles/alacritty/.config/alacritty/themes/github_dark_default.toml"
readonly theme_light_file="$HOME/dotfiles/alacritty/.config/alacritty/themes/github_light_default.toml"

if [ ! -f "$theme_file" ]; then
    setupTheme "$theme_file" "$theme_dark_file"
    exit 0
fi

if rg --fixed-strings --quiet "# Theme: dark" "${theme_file}"; then
    new_theme_file="$theme_light_file"
else
    new_theme_file="$theme_dark_file"
fi

setupTheme "$theme_file" "$new_theme_file"
