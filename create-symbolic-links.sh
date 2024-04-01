#!/bin/sh
ln -sf ~/.dotfiles/wezterm ~/.config/wezterm
ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig

#if [ "$(uname)" = "MINGW64_NT"* ]; then
if echo "$(uname)" | grep -q "MINGW64_NT"; then
  echo 'here'
  ln -sf ~/.dotfiles/nvim ~/AppData/Local/nvim
else 
  ln -sf ~/.dotfiles/nvim ~/.config/nvim
  ln -sf ~/.dotfiles/.bashrc ~/.bashrc
  ln -sf ~/.dotfiles/.zshrc ~/.zshrc
fi
