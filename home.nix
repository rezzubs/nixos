{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home = {
    username = "rezzubs";
    homeDirectory = "/home/rezzubs";

    packages = with pkgs; [
      fastfetch
      wl-clipboard
      htop
    ];

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

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
  };

  # https://nixos.org/manual/nixpkgs/stable/#sec-allow-unfree
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
}
