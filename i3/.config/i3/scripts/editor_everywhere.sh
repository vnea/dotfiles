#!/bin/sh

if [ $(wmctrl -l | grep "/tmp" --count) -gt 0 ]
then
  i3-msg "[class=\"jetbrains-idea\" title=\"^.*tmp$\"] focus"
  exit 0
fi

tmpfile=$(mktemp)
/snap/bin/intellij-idea-ultimate -e "${tmpfile}"

i=0
while [ $(wmctrl -l | grep "/tmp" --count) -ne 1 ]
do
  sleep 0.1

  i=$((i+1))
  [ $i -eq 300 ] && exit 1
done

i3_current_workspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
i3-msg "[class=\"jetbrains-idea\" title=\"^.*tmp$\"] move to workspace ${i3_current_workspace}, focus, move right"
