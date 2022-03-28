#!/bin/sh

## Create symlinks

cd ~/.dotfiles
# Make all the directories
find . -type d | cut -c3- | xargs -I {} mkdir -p ~/{}
# Symlink all the files (except .git and setup.sh)
find . -type f | cut -c3- | grep -vE '^(\.git|setup\.sh)' | xargs -I {} ln -s ~/.dotfiles/{} ~/{}

## Setup iterm2 preferences

# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/iterm2_profile"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

