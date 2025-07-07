#! /bin/bash

set -e


####
#     Previous guy had this set up as a standalone script via wget which clones the repo. 
#     Instead I'm gonna assume we cloned the repo to run this script.
#     This should work on a fresh (minimal) install 
####


# Setting up the [chaotic-aur] repo.
# Feel free to comment this section out if you don't want it

echo "Setting up [chaotic-aur] and adding it to Pacman"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf

# Initialize/update repos and update system. On fresh installation, this'll be short
sudo pacman -Syu --noconfirm

# Yeah we can do this now. yay is built and packaged by chaotic-aur, so it's easier this way
sudo pacman -S --noconfirm yay


NECESSARY_PKGS=(
    sddm niri waybar kitty fuzzel dunst hyprlock 
    kitty yazi thunar ttf-cascadia-code-nerd nano
    brightnessctl fastfetch rofi wget mpv swayidle
    fish tela-circle-icon-theme-dracula swaybg firefox
    waypaper catppuccin-gtk-theme-mocha
)

yay -S --noconfirm --needed "${NECESSARY_PKGS[@]}"
sudo systemctl enable sddm

# Please, feel free to edit these to your liking
# Of course, they're tailored to what I want on my system
# The below are yours to play with

OPTIONAL_PKGS=(
    thunar librewolf btop
    discord obsidian xournalpp
    better-control-git cliphist
    visual-studio-code-bin
)

yay -S --noconfirm --needed "${OPTIONAL_PKGS[@]}"



# A bunch of emoji nonsense just so Discord and such aren't annoying with random boxes

EMOJI_PKGS=(
    unicode-emoji
    nodejs-emojione
    noto-fonts-emoji
    haskell-emoji
)

yay -S --noconfirm --needed "${EMOJI_PKGS[@]}"




####################################
####################################

# This is for my fellow math nerds. Feel free to remove this whole section
# Be advised, TexLive-meta will take up a *lot* of space and time

MATH_PKGS=(
    pandoc-cli
    texlive-meta
    texworks
)

yay -S --noconfirm --needed "${MATH_PKGS[@]}"


# My personal Pandoc setup

PANDOC_FOLDER=$HOME/.local/share/pandoc
mkdir -p $PANDOC_FOLDER
cp -r ./pandocConfig/* $PANDOC_FOLDER
mkdir -p ~/Desktop
cp ./"Math PDF.desktop" ~/Desktop/"Math PDF.Desktop"
cp ./pandoc2.sh ~/pandoc2.sh

####################################
####################################


# Make the classic /home directory folders
cd
mkdir -p Desktop Documents Downloads Music Pictures Videos

# Pre-make some of these folders, for convenience. The script will exit if they're not there
cd ~/.config
mkdir -p niri dunst kitty waybar fastfetch yazi fuzzel mpv hypr rofi


# Sets the timezone to Los Angeles time (West Coast, baby!)
# Change this to whatever is relevant to you. Removing this defaults to UTC
sudo timedatectl set-timezone America/Los_Angeles



# Only thing left is to copy the actual dots 
# from the repo clone to ~/.config

cd ~/niri-dotfiles

echo "Moving the config files to ~/.config..."
mv ./niri ~/.config/
mv ./dunst ~/.config/
mv ./kitty ~/.config/
mv ./waybar ~/.config/
mv ./fastfetch ~/.config/
mv ./yazi ~/.config/
mv ./fuzzel ~/.config/
mv ./mpv ~/.config/
mv ./hypr ~/.config/
mv ./rofi/config ~/.config/rofi

echo "Putting rofi script in ~/.local/share/rofi..."
mv ./rofi/local ~/.local/share/rofi

echo "Moving wallpapers to ~/Pictures/Wallpapers..."
mv ./wallpapers ~/Pictures/Wallpapers
waypaper --set ~/Pictures/Wallpapers/"Grey Spaceman.png"

echo "Done!"
