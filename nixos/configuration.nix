{ config, lib, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./hyprland.nix
      #./sway.nix
      ./fonts.nix
      ./packages.nix
    ];

  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # BROWSER
  environment.variables = {
     BROWSER = "edge";
  };

  # TIME ZONE
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  # KEYBOARD
  services.xserver = {
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle,caps:escape";
    };
  };

  # Fix shift sticking issue
  services.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      tapping = true;
    };
  };

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # PIPEWIRE - sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
  };

  programs.zsh.enable = true;

  # USER ACCOUNT
  users.users.isodin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "plugdev" "input" "docker" ];
    hashedPassword = "$6$CmZnTbDq5n2soVZN$.9YqV3Vj9QfQVOPqHmeyog5ZZmYKVO5P/1Z1lslo8tslK2vaN8MeBX7EJyIPVrBNLDd17gzBwc5.WFNi1jRig1";
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  # BLUETOOTH
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
    XCURSOR_SIZE = "24";
  };
  # NETWORK
  networking.firewall.enable = false;
  networking.useDHCP = false;
  networking.networkmanager.enable = true;

  # VPN SERVICE
  services.zerotierone.enable = true;

  system.stateVersion = "25.05";
}
