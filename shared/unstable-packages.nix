# Adds `pkgs.unstable`, the nixos-unstable package set. Works in both NixOS and
# home-manager.
{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        # The config the stable set was built with, so both follow the same
        # policy (like the unfree allowlist).
        inherit (final) config;
      };
    })
  ];
}
