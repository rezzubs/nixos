{
  config,
  lib,
  ...
}: {
  options.custom.gaming.enable = lib.mkEnableOption "gaming related tools";

  config = lib.mkIf config.custom.gaming.enable {
    programs.lutris.enable = true;
  };
}
