{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  # hunk hasn't reached the 26.05 release channel yet.
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in {
  options.custom.cli.enable = lib.mkEnableOption "shell & common cli tools";

  config = lib.mkIf config.custom.cli.enable {
    home.packages =
      (with pkgs; [
        dust
        fastfetch
        file
        htop
        hyperfine
        just
        tealdeer
        tokei
        tree
        wl-clipboard
      ])
      ++ (with pkgs-unstable; [
        hunk
      ])
      ++ [
        inputs.herdr.packages.${pkgs.system}.default
      ];

    programs = {
      # better shell history
      atuin.enable = true;

      # `cat` but better
      bat.enable = true;

      # `find` but better
      fd.enable = true;

      # friendly interactive shell
      fish = {
        enable = true;
        functions = {
          fish_greeting = ''
            uptime
          '';
        };
      };

      # fuzzy finder
      fzf.enable = true;

      # grep but better
      ripgrep.enable = true;

      # terminal prompt
      starship.enable = true;

      # file manager `y`
      yazi.enable = true;

      # `cd` but better
      zoxide.enable = true;
    };
  };
}
