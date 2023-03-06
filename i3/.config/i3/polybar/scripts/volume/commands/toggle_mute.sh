#!/usr/bin/env bash

echo -n "toggle_mute" | nc --udp --close localhost 60001
