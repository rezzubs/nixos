{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.theming = {
    enable = lib.mkEnableOption "gtk theme and cursor";
  };

  config = lib.mkIf config.custom.theming.enable {
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
