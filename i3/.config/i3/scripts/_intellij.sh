#!/usr/bin/env bash

function open_idea() {
  readonly idea_version=$(ls --all -l -t --reverse ~/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/ | awk '{print $9}' | grep -E '^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+$' | tail -n 1)
  ~/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/"${idea_version}"/bin/idea.sh "${@}"
}
