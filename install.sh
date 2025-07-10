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
    brightnessctl fastfetch rofi-wayland wget mpv swayidle
    fish tela-circle-icon-theme-dracula swaybg firefox
    waypaper catppuccin-gtk-theme-mocha network-manager-applet
    bluez bluez-utils blueman catppuccin-sddm-theme-mocha
    xorg-xwayland xwayland-satellite
)

yay -S --noconfirm --needed "${NECESSARY_PKGS[@]}"

# Please, feel free to edit these to your liking
# Of course, they're tailored to what I want on my system
# The below are yours to play with

OPTIONAL_PKGS=(
    thunar librewolf btop
    discord obsidian xournalpp
    better-control-git cliphist
    visual-studio-code-bin
    filen-desktop-bin mousepad
    mesa glu vulkan-intel
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

echo "Setting up services..."
sudo systemctl enable sddm
sudo systemctl enable bluetooth

# Make the classic /home directory folders
cd
mkdir -p Desktop Documents Downloads Music Pictures Videos

# Pre-make some of these folders, for convenience. The script will exit if they're not there
cd ~/.config
mkdir -p niri dunst nvim kitty waybar fastfetch yazi fuzzel mpv hypr rofi waypaper gtk-3.0 gtk-4.0

# Initialize Fish and set it as the default shell
fish -c "true"
chsh -s $(which fish)

# Sets the timezone to Los Angeles time (West Coast, baby!)
# Change this to whatever is relevant to you. Removing this defaults to UTC

### If running from Arch ISO Chroot, you'll have to repeat this command yourself
sudo timedatectl set-timezone America/Los_Angeles


# Only thing left is to copy the actual dots 
# from the repo clone to ~/.config

cd ~/niri-dotfiles

echo "Moving the config files to ~/.config..."
mv ./niri ~/.config/
mv ./dunst ~/.config/
mv ./nvim ~/.config/
mv ./kitty ~/.config/
mv ./fish/config.fish ~/.config/fish/config.fish
mv ./waybar ~/.config/
mv ./fastfetch ~/.config/
mv ./yazi ~/.config/
mv ./fuzzel ~/.config/
mv ./mpv ~/.config/
mv ./hypr ~/.config/
mv ./waypaper ~/.config/
mv ./rofi/config ~/.config/rofi

echo "Setting up custom launchers..."
mv ./localApplications/ ~/.local/share/applications

echo "Putting rofi script in ~/.local/share/rofi..."
mv ./rofi/local ~/.local/share/rofi

echo "Setting up GTK settings..."
cp ./gtkSettings/settings.ini ~/.config/gtk-3.0/settings.ini
mv ./gtkSettings/settings.ini ~/.config/gtk-4.0/settings.ini
sudo mv ./sddm/sddm.conf /etc/sddm.conf

echo "Moving wallpapers to ~/Pictures/Wallpapers..."
mv ./wallpapers ~/Pictures/Wallpapers

echo "Done!"
