{
  config,
  pkgs-unstable,
  lib,
  pkgs,
  ...
}:
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

      # fuzzy finder
      fzf.enable = true;

      # A modern shell
      nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };

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
