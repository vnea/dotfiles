#!/usr/bin/env bash

function cy() {
  if [[ "$(uname)" == "Darwin" ]]; then
    pbcopy
  else
    xclip -sel clip
  fi
}
