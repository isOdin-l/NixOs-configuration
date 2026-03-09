{ config, lib, pkgs, nixpkgs-unstable, ... }:

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
    hashedPassword = "$6$CmZnTbDq5n2soVZN$.9YqV3Vj9QfQVOPqHmeyog5ZZmYKVO5P/1Z1lslo8tslK2vaN8MeBX7EJyIPVrBNLDd17gzBwc5.WFNi1jRig1";
    packages = with pkgs; [
      tree
    ];
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
  services.zerotierone.enable = true;

  system.stateVersion = "25.05";
}

