#!/usr/bin/env bash

source "./scripts/dock_functions.sh"

declare -a apps=(
    '/Applications/Google Chrome.app'
    '/Applications/iTerm.app'
    '/Applications/Obsidian.app'
    '/Applications/Spotify.app'
);

declare -a folders=(
    ~/Downloads
);

clear_dock

for app in "${apps[@]}"; do
    add_app_to_dock "$app"
done

for folder in "${folders[@]}"; do
    add_folder_to_dock $folder
done

killall Dock