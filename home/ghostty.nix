{
  config,
  lib,
  ...
}:
{
  # The shell to launch.
  imports = [ ./nushell.nix ];

  programs.ghostty = {
    enable = true;
    settings = {
      command = lib.getExe config.programs.nushell.package;
      theme = "Catppuccin Mocha";
      window-theme = "ghostty"; # use `theme` also for tab bars.
      window-decoration = "auto";
      mouse-hide-while-typing = true;
    };
  };
}
