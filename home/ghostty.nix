{
  config,
  lib,
  ...
}: {
  options.custom.ghostty.enable = lib.mkEnableOption "enable the ghostty terminal emulator";

  config = lib.mkIf config.custom.ghostty.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        command = "fish";
        theme = "Catppuccin Mocha";
        window-theme = "ghostty"; # use `theme` also for tab bars.
        window-decoration = "auto";
      };
    };
  };
}
