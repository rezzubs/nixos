# Common configs for all systems. Base for all other profiles.
{
  config,
  lib,
  ...
}: {
  imports = [
    ../modules
  ];

  custom = lib.mkDefault {
    bootLoader.enable = true;
    editor.enable = true;
    nix.enable = true;
    swap.enable = true;
    users.enable = true;
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  networking = lib.mkDefault {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  programs.nix-ld.enable = true;

  time.timeZone = lib.mkDefault "Europe/Tallinn";
}
