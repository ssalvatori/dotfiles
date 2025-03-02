#!/bin/bash

set -x

TMUX_BIN=/opt/homebrew/bin/tmux

SESSION_NAME="main"

# Check if the session already exists
${TMUX_BIN} has-session -t $SESSION_NAME 2>/dev/null

if [ $? -eq 0 ]; then
  # If the session exists, reattach to it
  ${TMUX_BIN} attach-session -t $SESSION_NAME
else
  # If the session doesn't exist, start a new one
  ${TMUX_BIN} new-session -s $SESSION_NAME -d
  ${TMUX_BIN} attach-session -t $SESSION_NAME
fi
