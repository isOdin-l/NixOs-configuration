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
    python313
    telegram-desktop
    obsidian
    waybar
    dunst
    libnotify  
    kitty
    rofi
    networkmanagerapplet
    catppuccin-cursors.mochaDark
    gnome-keyring
    libsecret
    seahorse
    nemo
    hyprshot
    hyprpaper
    libreoffice
    wlogout
    qalculate-gtk 
    gcc
    (pkgs.callPackage ../packages/yandex-music {})
    vlc
    trash-cli
    zip
    unzip
    ncdu
    postman
  ] ++[
    unstable.go_1_26
    unstable.opencode
    unstable.microsoft-edge
  ];
}
