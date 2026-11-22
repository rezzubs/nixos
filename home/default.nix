{ lib, ... }: {
  imports = [
    ./claude.nix
    ./cli.nix
    ./editor.nix
    ./gaming.nix
    ./ghostty.nix
    ./nix.nix
    ./obsidian.nix
    ./taltech-vpn.nix
    ./vcs.nix
  ];
}
