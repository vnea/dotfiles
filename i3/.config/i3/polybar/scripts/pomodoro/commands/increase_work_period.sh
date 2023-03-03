#!/usr/bin/env bash

echo -n "increase_work_period" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
