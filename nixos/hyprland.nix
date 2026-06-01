
{ config, lib, pkgs, nixpkgs-unstable, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    XWAYLAND_NO_GLAMOR = "1";
	  # WLR_NO_HARDWARE_CURSORS = "1";
	  NIXOS_OZONE_WL = "1";
	  QT_QPA_PLATFORM = "wayland;xcb";
		GDK_SCALE = "1";
		GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  hardware = {
	  graphics.enable = true;
	  nvidia.modesetting.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.sddm.enableGnomeKeyring = true;

}
