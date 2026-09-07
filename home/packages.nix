{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  # hunk hasn't reached the 26.05 release channel yet.
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
  };
in {
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
      pkgs-unstable.hunk
      tealdeer
      tokei
      tree
      wl-clipboard
    ];
  };
}
