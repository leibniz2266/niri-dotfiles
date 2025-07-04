#!/bin/bash


########
#         Currently a WIP. Trying to make the install
#         process idempotent. Next is a Modular variant
########




set -euo pipefail

# Helper function to check if a package is installed
is_pkg_installed() {
    pacman -Qi "$1" &>/dev/null
}

# Check if Chaotic-AUR repo is already configured
if ! grep -q '^\[chaotic-aur\]' /etc/pacman.conf; then
    echo "Setting up [chaotic-aur]..."
    
    # Import and sign key if not present
    if ! pacman-key -l | grep -q "3056513887B78AEB"; then
        sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
        sudo pacman-key --lsign-key 3056513887B78AEB
    fi

    # Install keyring and mirrorlist if not present
    for pkg in chaotic-keyring chaotic-mirrorlist; do
        if ! is_pkg_installed "$pkg"; then
            sudo pacman -U --noconfirm "https://cdn-mirror.chaotic.cx/chaotic-aur/${pkg}.pkg.tar.zst"
        fi
    done

    # Add repo entry
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf >/dev/null
    sudo pacman -Sy  # Refresh after repo addition
fi

# System update and yay installation
sudo pacman -Syu --noconfirm
if ! is_pkg_installed yay; then
    sudo pacman -S --noconfirm yay
fi

# Package installations with Pipewire
NECESSARY_PKGS=(
    sddm niri waybar kitty fuzzel dunst hyprlock 
    kitty yazi thunar ttf-cascadia-code-nerd nano
    brightnessctl fastfetch rofi wget mpv swayidle
    fish tela-circle-icon-theme-dracula swaybg firefox
    pipewire pipewire-alsa pipewire-pulse wireplumber pipewire-jack
)
yay -S --noconfirm --needed "${NECESSARY_PKGS[@]}"

OPTIONAL_PKGS=(
    thunar librewolf btop
    discord obsidian xournalpp
    better-control-git cliphist
    visual-studio-code-bin
)
yay -S --noconfirm --needed "${OPTIONAL_PKGS[@]}"

# Emoji support
EMOJI_PKGS=(
    unicode-emoji
    noto-fonts-emoji
)
yay -S --noconfirm --needed "${EMOJI_PKGS[@]}"

# Math/TeX setup (optional)
MATH_PKGS=(
    pandoc-cli
    texlive-meta
    texworks
)
yay -S --noconfirm --needed "${MATH_PKGS[@]}"

# Pandoc configuration
PANDOC_FOLDER="$HOME/.local/share/pandoc"
mkdir -p "$PANDOC_FOLDER"
[ -d "./pandocConfig" ] && cp -r ./pandocConfig/* "$PANDOC_FOLDER"
mkdir -p ~/Desktop
[ -f "./Math PDF.desktop" ] && cp "./Math PDF.desktop" ~/Desktop/
[ -f "./pandoc2.sh" ] && cp ./pandoc2.sh ~/

# Create standard directories
mkdir -p ~/{Desktop,Documents,Downloads,Music,Pictures,Videos}

# Config file deployment with idempotent replacement
cd ~/niri-dotfiles

declare -a config_dirs=(
    "niri" "dunst" "kitty" "waybar" "fastfetch" "yazi"
    "fuzzel" "mpv" "hypr"
)

echo "Deploying configuration files..."
for dir in "${config_dirs[@]}"; do
    src="./$dir"
    dest="$HOME/.config/$dir"
    
    if [ -d "$dest" ]; then
        echo "Removing existing $dest"
        rm -rf "$dest"
    fi
    mv -v "$src" "$dest"
done

# Rofi specific setup
if [ -d "./rofi/config" ]; then
    rofi_config_dir="$HOME/.config/rofi"
    mkdir -p "$rofi_config_dir"
    mv -v "./rofi/config" "$rofi_config_dir/"
fi

if [ -d "./rofi/local" ]; then
    rofi_local_dir="$HOME/.local/share/rofi"
    mkdir -p "$rofi_local_dir"
    mv -v "./rofi/local" "$rofi_local_dir/"
fi

# Wallpapers
[ -d "./wallpapers" ] && mv -v ./wallpapers ~/Pictures/

echo "Setup complete!"
echo "Note: For Pipewire, ensure your user session is restarted, or run:"
echo "systemctl --user enable --now pipewire pipewire-pulse"
