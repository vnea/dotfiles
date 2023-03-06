#!/usr/bin/env bash

echo -n "volume_down" | nc --udp --close localhost 60001

