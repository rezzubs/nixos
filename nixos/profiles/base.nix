# Common configs for all systems. Base for all other profiles.
{ lib, ... }:
{
  imports = [
    ../../shared/unstable-packages.nix
    ../bluetooth.nix
    ../bootloader.nix
    ../editor.nix
    ../home-manager.nix
    ../nix.nix
    ../swap.nix
    ../users.nix
  ];

  home-manager.users.rezzubs.imports = [ ../../home/profiles/base.nix ];

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  networking = lib.mkDefault {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  programs.nix-ld.enable = true;

  # Keep boot messages visible when the login prompt appears.
  systemd.services."getty@tty1".serviceConfig.TTYVTDisallocate = false;

  time.timeZone = lib.mkDefault "Europe/Tallinn";
}
