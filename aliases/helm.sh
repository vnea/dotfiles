#!/usr/bin/env bash

hd() {
 local sel release revs ctx r1 r2 n
  local -a args=()

  sel=$(helm list | fzf --header-lines=1 --prompt="Release > ") || return
  release=$(awk '{print $1}' <<<"$sel")

  revs=$(helm history "$release" \
    | { read -r h; echo "$h"; sort -k1,1nr; } \
    | fzf --header-lines=1 --multi --prompt="Revision(s) [TAB to select] > ") || return
  n=$(wc -l <<<"$revs")
  read -r r1 r2 <<<"$(awk '{print $1}' <<<"$revs" | sort -n | tr '\n' ' ')"

  printf "Context -C (empty = none): " >&2
  read -r ctx
  [[ -n "$ctx" ]] && args+=(-C "$ctx")

  case $((n)) in
    1) helm diff revision "$release" "$r1" "${args[@]}" "$@" ;;
    2) helm diff revision "$release" "$r1" "$r2" "${args[@]}" "$@" ;;
    *) echo "Select 1 or 2 revisions" >&2; return 1 ;;
  esac
}

hdy() {
  if [[ "$(uname)" == "Darwin" ]]; then
    hd "$@" --no-color | pbcopy
  else
    hd "$@" --no-color | xclip -sel clip
  fi
}
