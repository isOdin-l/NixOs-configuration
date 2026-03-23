{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "Telegram" ''
      QT_QPA_PLATFORM=xcb exec ${pkgs.telegram-desktop}/bin/Telegram "$@"
    '')
  ];
}
