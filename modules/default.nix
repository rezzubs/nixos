{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./editor.nix
    ./niri.nix
    ./nix.nix
    ./steam.nix
    ./swap.nix
    ./users.nix
    ./wakeup-fix.nix
    ./wayland.nix
  ];

  custom = lib.mkDefault {
    bootLoader.enable = true;
    editor.enable = true;
    niri.enable = true;
    nix.enable = true;
    swap.enable = true;
    users.enable = true;
  };

  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

  networking = lib.mkDefault {
    firewall.enable = true;
    networkmanager.enable = true;
  };

  services = lib.mkDefault {
    flatpak.enable = true;
    openssh.enable = true;
  };

  time.timeZone = lib.mkDefault "Europe/Tallinn";
}
