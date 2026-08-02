{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.editor.enable = lib.mkEnableOption "set helix as the editor";

  config = lib.mkIf config.custom.editor.enable {
    environment = {
      sessionVariables = {
        EDITOR = "hx";
      };
      systemPackages = [pkgs.helix];
    };

    programs.nano.enable = false;
  };
}
