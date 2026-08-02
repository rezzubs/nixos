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
  };

  networking.hostName = "desktop";
  hardware.bluetooth.enable = true;

  custom.steam.enable = true;
}
