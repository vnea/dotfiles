#!/usr/bin/env bash

alias lzd="lazydocker"
alias dps="docker ps"
alias dpsa="docker ps -a"

# Go in selected container with fzf via bash
function dbh {
  docker ps -a | tail -n+2 | awk '{print $2 "|" $NF}' | column -t -s "|" | fzf | awk '{print $2}' | xargs --no-run-if-empty -o -I container_name docker exec -it container_name /bin/bash
}

# Go in selected container with fzf via sh
function dsh {
  docker ps -a | tail -n+2 | awk '{print $2 "|" $NF}' | column -t -s "|" | fzf | awk '{print $2}' | xargs --no-run-if-empty -o -I container_name docker exec -it container_name /bin/sh
}

# Print logs of selected container with fzf
function dl {
  docker ps -a | tail -n+2 | awk '{print $2 "|" $NF}' | column -t -s "|" | fzf | awk '{print $2}' | xargs --no-run-if-empty docker logs -f
}

# Remove selected container with fzf
function drm {
  docker ps -a | tail -n+2 | awk '{print $2 "|" $NF}' | column -t -s "|" | fzf | awk '{print $2}' | xargs --no-run-if-empty docker rm -f --volumes
}

# Remove all containers
function drma() {
  container_ids=$(docker ps -aq)
  if [ -z "$container_ids" ]
  then
      echo "No container to remove."
  else
      # shellcheck disable=SC2086
      docker rm -f $container_ids
  fi
}
