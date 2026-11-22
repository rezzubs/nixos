{ ... }:
{
  nixpkgs.config.allowUnfreePackages = [ "obsidian" ];

  programs.obsidian.enable = true;
}
