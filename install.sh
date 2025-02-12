#! /bin/bash

set -e

echo "Cloning the dotfiles:"
git clone https://github.com/DoubleDotStudios/niri-dotfiles
cd ./niri-dotfiles

echo "Moving the config files to ~/.config..."
mv ./niri ~/.config/
mv ./nvim ~/.config/
mv ./dunst ~/.config/
mv ./kitty ~/.config/
mv ./waybar ~/.config/
mv ./fastfetch ~/.config/
mv ./yazi ~/.config/
mv ./fuzzel ~/.config/
mv ./mpv ~/.config/
mv ./hypr ~/.config/

echo "Moving wallpapers to ~/Pictures/Wallpapers..."
mv ./wallpapers ~/Pictures/Wallpapers

echo "Done!"
