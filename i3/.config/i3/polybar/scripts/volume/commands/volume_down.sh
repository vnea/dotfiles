#!/usr/bin/env bash

echo -n "volume_down" | nc --udp --close 127.0.0.1 60001

