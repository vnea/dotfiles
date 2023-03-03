#!/usr/bin/env bash

echo -n "decrease_timer" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
