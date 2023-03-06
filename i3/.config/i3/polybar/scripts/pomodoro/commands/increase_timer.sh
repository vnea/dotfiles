#!/usr/bin/env bash

echo -n "increase_timer" | nc --udp --close 127.0.0.1 60002
