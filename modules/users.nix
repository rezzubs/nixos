{
  config,
  lib,
  ...
}: {
  options.custom.users.enable = lib.mkEnableOption "add default users";

  config = lib.mkIf config.custom.users.enable {
    users.users.rezzubs = {
      extraGroups = ["wheel" "networkmanager"];
      isNormalUser = true;
    };
  };
}
