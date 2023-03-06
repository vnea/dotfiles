#!/usr/bin/env bash

function get_volume {
  amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
  amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off >/dev/null
}

function send_notification {
  base_icons_folder=/usr/share/icons/Papirus/48x48/status
  timeout=500
  replace_id=555

  if is_mute; then
    icon_name="$base_icons_folder/notification-audio-volume-muted.svg"
    echo "Muted"
    dunstify --replace $replace_id --appname Volume --icon "$icon_name" --timeout $timeout Muted
    return
  fi

  volume=$(get_volume)

  if [ "$volume" = "0" ]; then
    icon_name="$base_icons_folder/notification-audio-volume-muted.svg"
    text_volume="🔇 $volume"
  elif [ "$volume" -lt "30" ]; then
    icon_name="$base_icons_folder/notification-audio-volume-low.svg"
    text_volume="󰕿 $volume"
  elif [ "$volume" -lt "70" ]; then
    icon_name="$base_icons_folder/notification-audio-volume-medium.svg"
    text_volume="󰕾 $volume"
  else
    icon_name="$base_icons_folder/notification-audio-volume-high.svg"
    text_volume=" $volume"
  fi

  echo "$text_volume%"
  dunstify --replace $replace_id --appname Volume --icon "$icon_name" --timeout $timeout --hints int:value:"$volume" "$volume"
}

function print_formatted_volume {
  volume=$(get_volume)

  if is_mute; then
    text_volume="🔇 Muted"
  elif [ "$volume" = "0" ]; then
    text_volume="🔇 $volume%"
  elif [ "$volume" -lt "30" ]; then
    text_volume="󰕿 $volume%"
  elif [ "$volume" -lt "70" ]; then
    text_volume="󰕾 $volume%"
  else
    text_volume=" $volume%"
  fi

  echo "$text_volume"
}

case $1 in
get)
  print_formatted_volume
  ;;
up)
  amixer -D pulse set Master on >/dev/null
  amixer -D pulse sset Master 5%+ >/dev/null
  send_notification
  ;;
down)
  amixer -D pulse set Master on >/dev/null
  amixer -D pulse sset Master 5%- >/dev/null
  send_notification
  ;;
mute)
  amixer -D pulse set Master 1+ toggle >/dev/null
  send_notification
  ;;
esac
