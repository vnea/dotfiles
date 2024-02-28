#!/usr/bin/env bash

# Inspired from: https://dev.to/acro5piano/edit-tmux-output-with-editor-i1c

# Save current terminal scrollback with colors (-e arg)
terminal_scrollback=/tmp/terminal-scrollback
tmux capture-pane -e -pS - > $terminal_scrollback

# Open EDITOR in terminal mode
tmux new-window -n:terminal-scrollback "$EDITOR -c 'set nonumber' -c 'set norelativenumber' -c 'set spell!' -c 'terminal'"

# Hack to send to command to $EDITOR
tmux send-keys "i"
tmux send-keys "cat /tmp/terminal-scrollback"
tmux send-keys "Enter"
tmux send-keys "Escape"

# sleep because the G (to go to the bottom of the file) is triggered too soon
sleep 0.050
tmux send-keys "G"
