#!/usr/bin/env bash

echo -n "volume_up" | socat - UNIX-CLIENT:/tmp/volume.sock
