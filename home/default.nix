{lib, ...}: {
  imports = [
    ./claude.nix
    ./editor.nix
    ./gaming.nix
    ./niri.nix
    ./noctalia.nix
    ./nix.nix
    ./obsidian.nix
    ./packages.nix
    ./rounded-corners.nix
    ./terminal.nix
    ./vcs.nix
  ];

  custom = lib.mkDefault {
    claude.enable = true;
    editor.enable = true;
    obsidian.enable = true;
    packages.enable = true;
    terminal.enable = true;
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
