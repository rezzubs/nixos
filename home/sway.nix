# The sway config and the programs it starts.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./dotfiles.nix ];

  options.custom.sway.outputsFile = lib.mkOption {
    type = lib.types.path;
    default = ./sway/outputs;
    description = ''
      Sway config snippet with the monitor setup, included by the main config.
      Must be a file inside this repository: it is linked to the checkout like
      the main config.
    '';
  };

  config = {
    xdg.configFile = {
      "sway/config".source = config.custom.dotfiles.link ./sway/config;
      "sway/outputs".source = config.custom.dotfiles.link config.custom.sway.outputsFile;
    };

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
  };
}
