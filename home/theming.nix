{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  options.custom.theming = {
    enable = lib.mkEnableOption "gtk theme and cursor";
    noctalia = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "use the noctalia shell";
    };
  };

  config = lib.mkIf config.custom.theming.enable (lib.mkMerge [
    {
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
    }
    (lib.mkIf config.custom.theming.noctalia {
      programs.noctalia = {
        enable = true;
        # Starts automatically with graphical session.
        systemd.enable = true;
      };
    })
  ]);
}
