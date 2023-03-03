#!/usr/bin/env bash

echo -n "increase_timer" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
