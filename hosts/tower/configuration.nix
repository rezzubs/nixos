{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix/store".options = ["compress=zstd" "noatime"];

    "/mnt/data0" = {
      device = "/dev/disk/by-uuid/fda2eadb-817c-48c5-b6f9-fb69085c6433";
      fsType = "btrfs";
      options = [
        "users" # Allows any user to mount/unmount
        "nofail" # Allows system to continue to boot if drive cannot be mounted
        "exec" # Allows execution of files
        "compress=zstd"
      ];
    };
  };

  networking.hostName = "tower";
  hardware.bluetooth.enable = true;

  custom = {
    steam.enable = true;
    wakeupFix.enable = true;
  };

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
