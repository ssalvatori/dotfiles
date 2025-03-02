#!/usr/bin/env bash

# Source: https://macos-defaults.com/

defaults write com.apple.Finder ShowRecentTags -bool false # Disable tags in Finder
defaults write com.apple.Finder NewWindowTarget -string "PfHm" # Change default windows to $HOME 
defaults write com.apple.Finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.Finder ArchiveTimestamp -bool true # Enable timestamp in zip files
defaults write com.apple.Finder ShowStatusBar -bool true # show status bar
defaults write com.apple.Finder _FXSortFoldersFirst -bool true # folders on top when sorting by name
defaults write com.apple.Finder ShowPathbar -bool true # show path bar
defaults write com.apple.Dock wvous-tl-corner -int 0 # Disable hot corners
defaults write com.apple.Dock wvous-tr-corner -int 0 # Disable hot corners
defaults write com.apple.Dock wvous-bl-corner -int 0 # Disable hot corners
defaults write com.apple.Dock wvous-br-corner -int 0 # Disable hot corners
defaults write com.apple.Dock tilesize -int 62; # smaller icon sizes in Dock
defaults write com.apple.Dock launchanim -bool false # disable delay when you hide the Dock
defaults write com.apple.Dock autohide-delay -float 0 # disable delay when you hide the Dock

defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true" # show all file extensions
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false # Disable “natural” scrolling

defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 0 # Show volume in the menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -int 0 # Show Bluetooth in the menu bar
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false # Disable press-and-hold in VSCode
# defaults delete -g ApplePressAndHoldEnabled # Disable press-and-hold in all apps

mkdir -p ~/Pictures/Screenshots # Create screenshot folder

defaults write com.apple.screencapture "location" -string "~/Pictures/Screenshots" # Change screenshot location

defaults write com.apple.controlcenter.plist Bluetooth -int 18 # Show bluetooth in menubar

defaults write -g NSWindowShouldDragOnGesture -bool true # move windows ctrl+cmd

defaults write com.apple.dock expose-group-apps -bool true # group windows by application

defaults write com.apple.spaces spans-displays -bool true # disable Displays have separate Spaces

# defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true" # Show full URL in Safari

killall SystemUIServer
killall Finder
killall Dock
killall Safari

