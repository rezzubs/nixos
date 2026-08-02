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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
