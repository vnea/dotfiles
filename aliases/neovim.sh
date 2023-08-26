#!/usr/bin/env bash

function v {
  file_to_open="${1}"
  TERM=screen-256color nvim "${file_to_open}"
}

function vz {
  selected_file="$(fzf)"
  if [ -z "$selected_file" ]
  then
    return
  fi

  v "${selected_file}"
}

