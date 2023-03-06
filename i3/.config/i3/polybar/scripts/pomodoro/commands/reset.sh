#!/usr/bin/env bash

echo -n "reset" | nc --udp --close 127.0.0.1 60002
