{
  config,
  lib,
  ...
}: {
  options.custom.terminal.enable = lib.mkEnableOption "shell and terminal tools";

  config = lib.mkIf config.custom.terminal.enable {
    programs = {
      atuin.enable = true;

      fish = {
        enable = true;
        functions = {
          fish_greeting = ''
            uptime
          '';
        };
      };

      ghostty = {
        enable = true;
        settings = {
          command = "fish";
          theme = "Catppuccin Mocha";
          window-theme = "ghostty"; # use `theme` also for tab bars.
          window-decoration = "none";
          window-padding-x = 4;
          window-padding-y = 4;
        };
      };

      starship.enable = true;

      yazi.enable = true;
    };
  };
}
