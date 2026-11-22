# The sway config and the programs it starts.
{ config, pkgs, ... }:
{
  imports = [ ./dotfiles.nix ];

  xdg.configFile."sway/config".source = config.custom.dotfiles.link ./sway/config;

  home.packages = with pkgs; [
    # launcher
    fuzzel
    # notifications
    mako
    # screen lock and idle management
    swaylock
    swayidle
    # screenshots
    flameshot
    # night light
    wlsunset
  ];
}
