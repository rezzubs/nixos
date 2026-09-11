# Common toggles for desktop systems.
{
  config,
  lib,
  ...
}: {
  imports = [
    ./universal.nix
  ];

  custom = lib.mkDefault {
    kde.enable = true;
  };

  services = {
    flatpak.enable = true;
  };
}
