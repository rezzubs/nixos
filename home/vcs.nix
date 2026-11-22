# git and jujutsu version control.
{ pkgs, ... }:
{
  programs = {
    git.enable = true;

    jujutsu = {
      enable = true;
      package = pkgs.unstable.jujutsu;
      settings = {
        user = {
          email = "marten.roots@gmail.com";
          name = "Marten Roots";
        };
        ui.default-command = "log";
      };
    };
  };
}
