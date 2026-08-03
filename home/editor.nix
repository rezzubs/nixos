{
  config,
  lib,
  ...
}: {
  options.custom.editor.enable = lib.mkEnableOption "helix as the default editor";

  config = lib.mkIf config.custom.editor.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings.theme = "gruvbox";
    };
  };
}
