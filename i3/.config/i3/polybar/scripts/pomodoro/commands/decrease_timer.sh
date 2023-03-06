#!/usr/bin/env bash

echo -n "decrease_timer" | nc --udp --close 127.0.0.1 60002
