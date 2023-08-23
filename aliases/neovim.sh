#!/usr/bin/env bash

function v {
  file_to_open="${1}"
  nvim "${file_to_open}"
}

function vz {
  selected_file="$(fzf)"
  if [ -z "$selected_file" ]
  then
    return
  fi

  nvim "${selected_file}"
}

