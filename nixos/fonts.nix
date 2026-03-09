{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
  	nerd-fonts.jetbrains-mono
	  liberation_ttf
  	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-color-emoji  
  ];
}