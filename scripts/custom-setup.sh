#!/usr/bin/env bash

defaults write com.apple.Finder ShowRecentTags -bool false # Disable tags in Finder
defaults write com.apple.finder NewWindowTarget -string "PfHm" # Change default windows to $HOME 
defaults write com.apple.dock wvous-tl-corner -int 0 # Disable hot corners
defaults write com.apple.dock wvous-tr-corner -int 0 # Disable hot corners
defaults write com.apple.dock wvous-bl-corner -int 0 # Disable hot corners
defaults write com.apple.dock wvous-br-corner -int 0 # Disable hot corners
defaults write com.apple.finder AppleShowAllFiles YES; # show hidden files
defaults write com.apple.Finder ArchiveTimestamp -bool true # Enable timestamp in zip files
defaults write com.apple.dock tilesize -int 62; # smaller icon sizes in Dock
defaults write NSGlobalDomain AppleShowAllExtensions -bool true; # show all file extensions
defaults write com.apple.Finder _FXSortFoldersFirst -bool true # folders on top when sorting by name
defaults write com.apple.Finder ShowStatusBar -bool true # show status bar
defaults write com.apple.Finder ShowPathbar -bool true # show path bar
defaults write com.apple.Dock launchanim -bool false # disable delay when you hide the Dock
defaults write com.apple.Dock autohide-delay -float 0 # disable delay when you hide the Dock
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false # Disable “natural” scrolling
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 0 # Show volume in the menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -int 0 # Show Bluetooth in the menu bar

killall Finder && killall Dock