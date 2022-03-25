#!/bin/sh

# Source: https://github.com/Raymo111/i3lock-color/blob/master/examples/lock.sh

BLANK=#00000000
CLEAR=#ffffff22
DEFAULT=#e36a24
TEXT=#e36a24
WRONG=#880000bb
VERIFYING=#e36a24

i3lock \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
\
--blur 50                    \
--clock                      \
--time-str="%H:%M:%S"        \
--date-str="%A %d %B"
