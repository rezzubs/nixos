{
  config,
  lib,
  ...
}: {
  options.custom.obsidian.enable = lib.mkEnableOption "obsidian";

  config = lib.mkIf config.custom.obsidian.enable {
    custom.unfreePackages = ["obsidian"];

    programs.obsidian.enable = true;
  };
}
