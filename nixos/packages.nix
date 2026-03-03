{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    blueman
    bluez
    git
    git-lfs
    vscode
    go_1_25
    python313
    telegram-desktop
    obsidian
    microsoft-edge
    (waybar.overrideAttrs (oldAttrs: {mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];})) # Line on top
    dunst # Notifier
    libnotify  
    kitty # Terminal
    rofi-wayland
    networkmanagerapplet
    catppuccin-cursors.mochaDark # Cursor
    gnome-keyring # tool for saving passwords in browser
    libsecret
    seahorse
    nemo # File Manager
    hyprshot # Print Screen
    hyprpaper # Wallpapers
    libreoffice # Work with office documents
    wlogout # Pretty logout manager
    qalculate-gtk # Calculator 
    gcc # C/C++ languages
    (pkgs.callPackage ../packages/yandex-music {}) # Yandex-music (custom package)
    vlc # Media player
    trash-cli
    opencode # AI-agent tool
    #typst # milestone text-compiler instead of Word and Latex
    godot # Game engine
  ];
}