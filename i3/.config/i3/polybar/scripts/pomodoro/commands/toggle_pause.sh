#!/usr/bin/env bash

echo -n "toggle_pause" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
