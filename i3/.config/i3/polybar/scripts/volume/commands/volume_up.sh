#!/usr/bin/env bash

echo -n "volume_up" | nc --udp --close 127.0.0.1 60001
