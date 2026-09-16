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

        language = let
          # Common settings applied to all languages.
          commonConfig = {
            auto-format = true;
          };
          # Language level overrides. Empty table to include at least the common
          # config.
          languages = {
            python = {
              # Uncomment when the next release of helix lands. See
              # https://github.com/helix-editor/helix/pull/14481
              # language-servers = ["ruff" "ty"];
              # code-actions-on-save = ["source.organizeImports.ruff"];
            };
            rust = {};
          };
        in
          lib.mapAttrsToList (
            name: values:
              commonConfig
              // {
                inherit name;
              }
              // values
          )
          languages;
      };
    };
  };
}
