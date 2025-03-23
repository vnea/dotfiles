#!/usr/bin/env bash

function v {
  file_to_open="${1}"

  if [ -z "${file_to_open}" ]
  then
    nvim
  else
    nvim "${file_to_open}"
  fi
}

function vz {
  selected_file="$(fzf)"
  if [ -z "$selected_file" ]
  then
    return
  fi

  v "${selected_file}"
}
