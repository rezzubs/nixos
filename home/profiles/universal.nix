# Defaults for all machines.
{lib, ...}: {
  imports = [../.];

  custom = lib.mkDefault {
    claude.enable = true;
    cli.enable = true;
    editor.enable = true;
    vcs.enable = true;
  };

  home = {
    username = "rezzubs";
    homeDirectory = "/home/rezzubs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.home-manager.autoExpire.enable = true;
}
