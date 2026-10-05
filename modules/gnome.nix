{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./wayland.nix
  ];

  options.custom.gnome = {
    enable = lib.mkEnableOption "enable the GNOME desktop environment";
  };

  config = lib.mkIf config.custom.gnome.enable {
    custom.wayland.enable = true;

    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];
  };
}
