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

  networking.hostName = "desktop";
  hardware.bluetooth.enable = true;

  custom.steam.enable = true;
}
