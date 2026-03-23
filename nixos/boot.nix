{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
  };
}