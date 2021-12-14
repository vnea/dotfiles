#!/bin/sh

choice=$(echo "Logout\nReboot\nShutdown\nCancel" | dmenu -fn 'Ubuntu:pixelsize=35' -i -p "What do you want to do ?")

if [ "$choice" = "Logout" ];
  then i3-msg exit;
elif [ "$choice" = "Reboot" ];
  then reboot;
elif [ "$choice" = "Shutdown" ];
  then poweroff;
fi
