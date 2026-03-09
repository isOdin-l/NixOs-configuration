{ config, pkgs, nixpkgs-unstable, ... }:

let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    wget
    blueman
    bluez
    git
    git-lfs
    vscode
    unstable.go_1_26
    python313
    unstable.telegram-desktop
    obsidian
    unstable.microsoft-edge
    (waybar.overrideAttrs (oldAttrs: {mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];})) # Line on top
    dunst # Notifier
    libnotify  
    kitty # Terminal
    rofi
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
    unstable.opencode # AI-agent tool
    #typst # milestone text-compiler instead of Word and Latex
    godot # Game engine
    zip
    unzip
    ncdu
    postman
  ];
}
