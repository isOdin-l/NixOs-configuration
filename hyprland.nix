
{ config, lib, pkgs, ... }:

{ 
  programs.hyprland.enable = true;

  environment.sessionVariables = {
	WLR_NO_HARDWARE_CURSORS = "1";
	NIXOS_OZONE_WL = "1";
  };

  hardware = {
	graphics.enable = true;
	nvidia.modesetting.enable = true;
  };
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

}
