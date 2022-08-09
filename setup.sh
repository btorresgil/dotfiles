#!/bin/zsh

## Create symlinks

cd "$HOME/.dotfiles" || exit
# Make all the directories
find . -type d | cut -c3- | xargs -I {} mkdir -p "$HOME/{}"
# Symlink all the files (except .git and setup.sh)
find . -type f | cut -c3- | grep -vE '^(\.git|setup\.sh)' | xargs -I {} ln -s "$HOME/.dotfiles/{}" "$HOME/{}"

## Setup iterm2 preferences

if [ "$(uname)" = "Darwin" ]; then
  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$HOME/.dotfiles/iterm2_profile"
  # Tell iTerm2 to use the custom preferences in the directory
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
fi

