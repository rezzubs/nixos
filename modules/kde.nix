{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./wayland.nix
  ];

  options.custom.kde = {
    enable = lib.mkEnableOption "enable KDE Plasma";
  };

  config = lib.mkIf config.custom.kde.enable {
    custom.wayland.enable = true;

    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      konsole
    ];
  };
}
