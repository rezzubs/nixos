{
  config,
  lib,
  pkgs,
  ...
}: {
  options.custom.packages.enable = lib.mkEnableOption "common CLI packages";

  config = lib.mkIf config.custom.packages.enable {
    home.packages = with pkgs; [
      dust
      fastfetch
      htop
      hyperfine
      tealdeer
      tokei
      tree
      wl-clipboard
    ];
  };
}
