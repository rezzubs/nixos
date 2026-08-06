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

      settings = {
        theme = "catppuccin_mocha";

        editor = {
          line-number = "relative";

          cursor-shape = {
            insert = "bar";
            normal = "block";
          };
        };
      };

      languages = {
        language-server.rust-analyzer.config = {
          check.command = "clippy";
        };
      };
    };
  };
}
