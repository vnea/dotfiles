#!/usr/bin/env bash

echo -n "volume_up" | nc --udp --close localhost 60001
