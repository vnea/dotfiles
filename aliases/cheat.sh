#!/usr/bin/env bash

function ch {
  search_term="$1"
  curl "cheat.sh/$search_term"
}
