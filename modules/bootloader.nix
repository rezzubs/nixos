{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.bootLoader.enable = lib.mkEnableOption "enable boot loader configuration";

  config = lib.mkIf config.custom.bootLoader.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
