# Common toggles for desktop systems.
{lib, ...}: {
  imports = [
    ./universal.nix
  ];

  custom = lib.mkDefault {
    gnome.enable = true;
  };

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    flatpak.enable = true;
  };
}
