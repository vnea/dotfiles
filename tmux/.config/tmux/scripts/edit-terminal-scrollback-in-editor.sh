#!/usr/bin/env bash

# Inspired from: https://dev.to/acro5piano/edit-tmux-output-with-editor-i1c

# Save current terminal scrollback with colors (-e arg)
terminal_scrollback=/tmp/terminal-scrollback
tmux capture-pane -e -pS - > $terminal_scrollback

# Remove empty lines at the end of the file, generated with ChatGPT
sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' $terminal_scrollback

# Open EDITOR in terminal mode
tmux new-window -n:terminal-scrollback "$EDITOR -c 'set nonumber' \
                                                -c 'set norelativenumber' \
                                                -c 'set spell!' \
                                                -c 'terminal' \
                                                -c 'startinsert'"

tmux send-keys "cat /tmp/terminal-scrollback"
tmux send-keys "Enter"
tmux send-keys "Escape"
sleep 0.050
tmux send-keys "G"
