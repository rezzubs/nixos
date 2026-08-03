{lib, ...}: {
  imports = [
    ./claude.nix
    ./editor.nix
    ./gaming.nix
    ./packages.nix
    ./terminal.nix
    ./theming.nix
    ./vcs.nix
  ];

  custom = lib.mkDefault {
    claude.enable = true;
    editor.enable = true;
    packages.enable = true;
    terminal.enable = true;
    theming.enable = true;
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
