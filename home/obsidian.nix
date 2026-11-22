{
  config,
  lib,
  ...
}:
{
  options.custom.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.custom.obsidian.enable {
    nixpkgs.config.allowUnfreePackages = [ "obsidian" ];

    programs.obsidian.enable = true;
  };
}
