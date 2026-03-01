{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./bootloader.nix
      ./hyprland.nix
      ./fonts.nix
      ./packages.nix
    ];

  nixpkgs.config.allowUnfree = true;  
  virtualisation.docker.enable = true;

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
    xkb.layout = "us,ru";
    xkb.options = "grp:alt_shift_toggle";
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

  # TOUCHPAD
  services.libinput.enable = true;

  # USER ACCOUNT
  users.users.isodin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "plugdev" "input" "docker" ];
    password = "26971";
    packages = with pkgs; [
      tree
    ];
  };

  # BROWSER
  environment.variables = {
     BROWSER = "edge";
  };

  # NETWORK
  networking.useDHCP = false;
  networking.networkmanager.enable = true;

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

  # VPN SERVICE
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "08752e18b1bcb0e0"
    ];
  };

  system.stateVersion = "25.05";
}

