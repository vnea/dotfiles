#!/usr/bin/env bash

gnome-terminal ~
i=0
while [ $(wmctrl -lx | grep "gnome-terminal-server" --count) -ne 1 ]
do
  sleep 0.1

  i=$((i+1))
  [ $i -eq 300 ] && exit 1
done

i3-msg "move right"
