#!/usr/bin/env bash

echo -n "decrease_work_period" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
