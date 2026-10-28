{
  config,
  pkgs-unstable,
  lib,
  ...
}:
{
  options.custom.vcs.enable = lib.mkEnableOption "git and jujutsu version control";

  config = lib.mkIf config.custom.vcs.enable {
    programs = {
      git = {
        enable = true;
        ignores = lib.optionals config.custom.claude.enable [
          ".claude"
          "CLAUDE.md"
        ];
      };

      jujutsu = {
        enable = true;
        package = pkgs-unstable.jujutsu;
        settings = {
          user = {
            email = "marten.roots@gmail.com";
            name = "Marten Roots";
          };
          ui.default-command = "log";
        };
      };
    };
  };
}
