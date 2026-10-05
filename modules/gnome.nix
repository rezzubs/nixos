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
      gnome = {
        # The default app selection is bloated, the ones we want are installed
        # explicitly.
        core-apps.enable = false;
        # file previewer for nautilus.
        sushi.enable = true;
      };
    };

    programs = {
      # disk management
      gnome-disks.enable = true;

      # secrets management
      seahorse.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # image viewer
      loupe
      # file manager
      nautilus
      # disk usage analyzer
      baobab

      gnome-calendar
      gnome-clocks
      gnome-contacts
    ];
  };
}
