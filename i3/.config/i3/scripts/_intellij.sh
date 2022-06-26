#!/usr/bin/env bash

function get_ide_version() {
  ide_channel_path="${1}"
  idea_version=$(ls --all -l -t --reverse "${ide_channel_path}" | awk '{print $9}' | grep -E '^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$' | tail -n 1)
}

function open_idea() {
  ide_channel_path=~/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0
  get_ide_version "${ide_channel_path}"
  "${ide_channel_path}/${idea_version}/bin/idea.sh" "${@}"
}

function open_rider() {
  ide_channel_path=~/.local/share/JetBrains/Toolbox/apps/Rider/ch-0
  get_ide_version "${ide_channel_path}"
  "${ide_channel_path}/${idea_version}/bin/rider.sh"
}
