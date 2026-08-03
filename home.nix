{
  config,
  inputs,
  lib,
  pkgs,
  nixpkgs-unstable,
  ...
}: let
  pkgs-unstable = import nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfreePredicate = pkg:
      lib.getName pkg == "claude-code";
  };
in {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home = {
    username = "rezzubs";
    homeDirectory = "/home/rezzubs";

    packages =
      (with pkgs; [
        dust
        fastfetch
        htop
        hyperfine
        tealdeer
        tokei
        tokei
        tree
        wl-clipboard
      ])
      ++ (with pkgs-unstable; [
        claude-code
      ]);

    sessionVariables = {};
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk3.theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  programs = {
    atuin.enable = true;

    fish.enable = true;

    ghostty = {
      enable = true;
      settings = {
        command = "fish";
        theme = "Gruvbox Dark";
        window-decoration = "none";
        window-padding-x = 4;
        window-padding-y = 4;
      };
    };

    lutris.enable = true;

    git.enable = true;

    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "gruvbox";
      };
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "marten.roots@gmail.com";
          name = "Marten Roots;";
        };
      };
    };

    noctalia = {
      enable = true;
      # Starts automatically with graphical session.
      systemd.enable = true;
    };

    starship.enable = true;

    yazi.enable = true;

    zed-editor.enable = true;
  };

  services.home-manager.autoExpire.enable = true;

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
}
