#!/usr/bin/env bash

echo -n "toggle_mute" | nc --udp --close 127.0.0.1 60001
