#!/usr/bin/env bash

echo -n "reset" | socat - UNIX-CLIENT:/tmp/pomodoro.sock
