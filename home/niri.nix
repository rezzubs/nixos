{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.niri = {
    enable = lib.mkEnableOption "the niri config file";

    hostConfig = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Host-specific niri config (e.g. monitor outputs), appended to the shared config.";
    };
  };

  config = lib.mkIf config.custom.niri.enable {
    custom.roundedCorners.enable = true;

    home.packages = [
      pkgs.playerctl # MPRIS media controls
    ];

    home.file.".config/niri/config.kdl".text =
      builtins.readFile ./niri/config.kdl
      + lib.optionalString (config.custom.niri.hostConfig != null) (builtins.readFile config.custom.niri.hostConfig);

    gtk = {
      enable = true;
      colorScheme = "dark";
      gtk3.theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
    };

    home.pointerCursor = {
      enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
}
