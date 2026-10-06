# Defaults for machines with a graphical environment
{
  inputs,
  lib,
  pkgs,
  ...
}: let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in {
  imports = [./universal.nix];

  custom = lib.mkDefault {
    ghostty.enable = true;
    obsidian.enable = true;
  };

  programs.firefox = {
    enable = true;
    # firefox 157 is not in stable yet
    package = pkgs-unstable.firefox;
  };
}
