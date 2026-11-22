# Gaming related tools.
{ pkgs, ... }:
{
  programs.lutris.enable = true;

  home.packages = with pkgs; [
    yafc-ce
  ];
}
