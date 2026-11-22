{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.claude.enable = lib.mkEnableOption "claude code";

  config = lib.mkIf config.custom.claude.enable {
    nixpkgs.config.allowUnfreePackages = [ "claude-code" ];

    home.packages = [ pkgs.unstable.claude-code ];
  };
}
