# Common toggles for desktop systems.
{lib, ...}: {
  imports = [
    ./universal.nix
  ];

  custom = lib.mkDefault {
    gnome.enable = true;
  };

  services = {
    flatpak.enable = true;
  };
}
