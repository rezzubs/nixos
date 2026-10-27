{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in
{
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
        herdr
      ]);

    programs = {
      # better shell history
      atuin.enable = true;

      # `cat` but better
      bat.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

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
      starship = {
        enable = true;
        package = pkgs-unstable.starship;
      };

      # file manager `y`
      yazi.enable = true;

      # `cd` but better
      zoxide.enable = true;
    };
  };
}
