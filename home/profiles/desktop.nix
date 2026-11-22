# Defaults for machines with a graphical environment
{ pkgs, ... }:
{
  imports = [
    ./universal.nix
    ../ghostty.nix
    ../obsidian.nix
  ];

  programs.firefox = {
    enable = true;
    # firefox 157 is not in stable yet
    package = pkgs.unstable.firefox;
  };
}
