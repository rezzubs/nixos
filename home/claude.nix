{ pkgs, ... }:
{
  nixpkgs.config.allowUnfreePackages = [ "claude-code" ];

  home.packages = [ pkgs.unstable.claude-code ];

  programs.git.ignores = [
    ".claude"
    "CLAUDE.md"
  ];
}
