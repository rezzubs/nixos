{
  config,
  lib,
  ...
}: {
  options.custom.vcs.enable = lib.mkEnableOption "git and jujutsu version control";

  config = lib.mkIf config.custom.vcs.enable {
    programs = {
      git.enable = true;

      jujutsu = {
        enable = true;
        settings.user = {
          email = "marten.roots@gmail.com";
          name = "Marten Roots;";
        };
      };
    };
  };
}
