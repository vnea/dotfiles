#!/bin/sh

sketchybar --set "$NAME" label="$(LC_TIME=fr_FR.UTF-8 date +'%a %d %b %Y')"
