# niri-Dotfiles

---

[Preview](#preview)  
[Dependencies](#dependencies)  
[Extras](#optional-extras)  
[Install Script](#install-script)  
[Manual Install](#manual-install)  
[Credit](#credit)  

---

## Preview

![Empty](<./assets/Blank.png>)
*Blank Workspace*  


![Empty](<./assets/Fetch.png>)
*Fastefetch, Kitty and Firefox*  


![Empty](<./assets/Solarvim.png>)
*Neovim Config*  


![Empty](<./assets/Floating.png>)
*Yazi and mpv*  


![Empty](<./assets/Launcher.png>)
*Waybar app launcher*  


---

## Dependencies
- niri

- fuzzel
- waybar
- dunst
- hyprlock

- neovim
- kitty
- yazi

- CaskaydiaCove Nerd Font / CascadiaCode
- Tela Circle Dracula Icons

---

## Optional Extras
> lacking some require modification of the niri config file, indicated by *

- \* firefox
- \* brightnessctl
- \* discord

- fastfetch

---

## Install Script

> [!IMPORTANT]
> To use the install script the following should be installed:  
> Wget, Git, Niri, Fuzzel, Neovim, Dunst, Fuzzel, Fastfetch, Yazi, Kitty, mpv, Hyprlock, Swayidle and Swaybg

1. Download the install script:
```console
wget https://raw.githubusercontent.com/DoubleDotStudios/niri-dotfiles/refs/heads/main/install.sh
```

2. Make the script executable:
```console
chmod +x install.sh
```

3. Run the installer:
```console
./install.sh
```

---

## Manual Install

1. Clone the repo:
```console
git clone https://github.com/DoubleDotStudios/niri-dotfiles
cd ./niri-dotfiles
```

2. Move all directories except `wallpapers` to `~/.config`:
```console
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
```

3. Move `wallpapers` to `~/Pictures/Wallpapers/`:
```console
mv ./wallpapers ~/Pictures/Wallpapers
```

---

### Credit

Catppuccin: [mpv](https://github.com/catppuccin/mpv), [Yazi](https://github.com/catppuccin/yazi), [Hyprlock](https://github.com/catppuccin/hyprlock), [Fuzzel](https://github.com/catppuccin/fuzzel)  
Sansroot: [Waybar](https://github.com/sansroot/hypr-dots/tree/mauve/waybar)
