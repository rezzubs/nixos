{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.custom.packages.enable = lib.mkEnableOption "common CLI packages";

  config = lib.mkIf config.custom.packages.enable {
    home.packages = with pkgs; [
      dust
      fastfetch
      file
      htop
      hyperfine
      inputs.herdr.packages.${pkgs.system}.default
      just
      tealdeer
      tokei
      tree
      wl-clipboard
    ];
  };
}
