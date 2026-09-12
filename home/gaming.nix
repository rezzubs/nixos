{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.gaming.enable = lib.mkEnableOption "gaming related tools";

  config = lib.mkIf config.custom.gaming.enable {
    programs.lutris.enable = true;

    home.packages = with pkgs; [
      yafc-ce
    ];
  };
}
