#!/bin/bash

current_path=$(tmux display-message -p -F "#{pane_current_path}")
tmux rename-window "`basename $current_path`"
