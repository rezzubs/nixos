# Helix as the system editor.
{ pkgs, ... }:
{
  environment = {
    sessionVariables = {
      EDITOR = "hx";
    };
    systemPackages = [ pkgs.helix ];
  };

  programs.nano.enable = false;
}
