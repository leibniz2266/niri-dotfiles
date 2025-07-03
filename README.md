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

The basics to get the rice started are below:

- niri
- fuzzel
- waybar
- dunst
- hyprlock
- rofi
- kitty
- yazi
- CaskaydiaCove Nerd Font / CascadiaCode
- Tela Circle Dracula Icons
- swayidle
- swaybg
- hyprlock

The setup script `install.sh` actually takes care of all of these, so don't worry too much. Of course, read through the install script to see what else will be installed. 

---

## Optional Extras
> If you're missing those marked with \*stars\*, you may have to adjust/modify the main Niri config file (mostly just keybinds)

- \* librewolf
- \* brightnessctl

- fastfetch

These are included by default in the setup script, so you'll be fine unless you choose to remove them - just don't forget the Niri config if you do.

---

## Install Script

> [!IMPORTANT]
> To use the install script, you need an Arch (or a derivative) and `git` installed. It's been written with a minimal installation in mind, so bear in mind that you may have weird conflicts if you're not using a new install.

1. Download the repo:
```console
git clone https://github.com/Leibniz2266/niri-dotfiles && cd ./niri-dotfiles
```

2. *Please* read the setup script, specifically the lists of packages to be installed. They were all tailored to me, so I recommend you pick and choose what you want to install from the non-necessary package lists. 

    **Otherwise, expect a lot of bloat**

3. Make the script executable:
```console
chmod +x install.sh
```

4. Run the installer:
```console
./install.sh
```

---

## Manual Install

1. Clone the repo:
```console
git clone https://github.com/Leibniz2266/niri-dotfiles
cd ./niri-dotfiles
```

2. Move all directories except `wallpapers` and `rofi/local` to `~/.config`:
```console
mv ./niri ~/.config/
mv ./dunst ~/.config/
mv ./kitty ~/.config/
mv ./waybar ~/.config/
mv ./fastfetch ~/.config/
mv ./yazi ~/.config/
mv ./fuzzel ~/.config/
mv ./mpv ~/.config/
mv ./hypr ~/.config/
```

3. Move `rofi/local` to `~/.local/share/rofi`
```
mv ./rofi/local ~/.local/share/rofi
```

3. Move `wallpapers` to `~/Pictures/Wallpapers`:
```console
mv ./wallpapers ~/Pictures/Wallpapers
```

---

### Credit

Catppuccin: [mpv](https://github.com/catppuccin/mpv), [Yazi](https://github.com/catppuccin/yazi), [Hyprlock](https://github.com/catppuccin/hyprlock), [Fuzzel](https://github.com/catppuccin/fuzzel)  
Sansroot: [Waybar](https://github.com/sansroot/hypr-dots/tree/mauve/waybar)  
Lactua: [Rofi](https://github.com/lactua/dotfiles/tree/master/dots/rofi)
