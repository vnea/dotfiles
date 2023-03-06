#!/usr/bin/env bash

echo -n "volume_down" | socat - UNIX-CLIENT:/tmp/volume.sock
