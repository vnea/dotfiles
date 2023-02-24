#!/usr/bin/env bash

choice=$(printf "Logout\nReboot\nShutdown\nCancel" | rofi -i -dmenu -p "What do you want to do")

if [ "$choice" = "Logout" ]; then
  i3-msg exit
elif [ "$choice" = "Reboot" ]; then
  reboot
elif [ "$choice" = "Shutdown" ]; then
  poweroff
fi
