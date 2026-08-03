{
  config,
  lib,
  ...
}: {
  options.custom.terminal.enable = lib.mkEnableOption "shell and terminal tools";

  config = lib.mkIf config.custom.terminal.enable {
    programs = {
      atuin.enable = true;

      fish.enable = true;

      ghostty = {
        enable = true;
        settings = {
          command = "fish";
          theme = "Gruvbox Dark";
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
