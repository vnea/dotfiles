#!/usr/bin/env bash

echo -n "toggle_mute" | socat - UNIX-CLIENT:/tmp/volume.sock
