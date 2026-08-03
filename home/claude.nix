{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfreePredicate = pkg: lib.getName pkg == "claude-code";
  };
in {
  options.custom.claude.enable = lib.mkEnableOption "claude code";

  config = lib.mkIf config.custom.claude.enable {
    home.packages = [pkgs-unstable.claude-code];
  };
}
