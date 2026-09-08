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

        keys.normal.space.t = ":toggle soft-wrap.enable";

        editor = {
          line-number = "relative";

          cursor-shape = {
            insert = "bar";
            normal = "block";
          };

          indent-guides.render = true;
        };
      };

      languages = {
        language-server.rust-analyzer.config = {
          check.command = "clippy";
        };

        # Generate an auto-format block for all languages listed below.
        language =
          map (name: {
            inherit name;
            auto-format = true;
          }) [
            "python"
            "rust"
          ];
      };
    };
  };
}
