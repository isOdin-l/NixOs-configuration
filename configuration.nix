{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hyprland.nix
    ];

  nixpkgs.config.allowUnfree = true;  
  virtualisation.docker.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;  

  # Setting default browser
  environment.variables = {
     BROWSER = "edge";
  };

  # Time zone
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  # KEYBOARD LANGUAGES
  services.xserver = {
    xkb.layout = "us,ru";
    xkb.options = "grp:alt_shift_toggle";
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };


  # PIPEWIRE
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  # TOUCHPAD
  services.libinput.enable = true;

  # USER ACCOUNT.
  users.users.isodin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "plugdev" "input" "docker" ];
    password = "26971";
    packages = with pkgs; [
      tree
    ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
     wget
     blueman
     bluez
     git
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
     catppuccin-cursors.mochaDark
     gnome-keyring
     libsecret
     seahorse
     nemo
     hyprshot # Print Screen
     hyprpaper # Wallpapers
     libreoffice
     wlogout # Pretty logout manager
     qalculate-gtk # Calculator 
     gcc # C/C++ languages
     (pkgs.callPackage /home/isodin/packages/yandex-music {}) # Yandex-music (custom package)
     vlc # Media player
];

  # Fonts
  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
	liberation_ttf
  	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji  
];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

