# Defaults for all machines.
{ ... }: {
  imports = [
    ../../shared/unstable-packages.nix
    ../claude.nix
    ../cli.nix
    ../editor.nix
    ../vcs.nix
  ];

  home = {
    username = "rezzubs";
    homeDirectory = "/home/rezzubs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services.home-manager.autoExpire.enable = true;
}
