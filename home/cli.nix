# Shell and common CLI tools.
{ pkgs, ... }:
{
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
    ])
    ++ (with pkgs.unstable; [
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

    # grep but better
    ripgrep.enable = true;

    # terminal prompt
    starship = {
      enable = true;
      package = pkgs.unstable.starship;
    };

    # file manager `y`
    yazi.enable = true;

    # `cd` but better
    zoxide.enable = true;
  };
}
