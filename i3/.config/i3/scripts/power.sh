#!/usr/bin/env sh

choice=$(echo "Logout\nReboot\nShutdown\nCancel" | rofi -dmenu -p "What do you want to do")

if [ "$choice" = "Logout" ];
  then i3-msg exit;
elif [ "$choice" = "Reboot" ];
  then reboot;
elif [ "$choice" = "Shutdown" ];
  then poweroff;
fi
