#!/usr/bin/env bash

echo -n "toggle_pause" | nc --udp --close 127.0.0.1 60002
