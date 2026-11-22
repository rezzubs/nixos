{ lib, ... }: {
  imports = [
    ../shared/unstable-packages.nix
    ./claude.nix
    ./cli.nix
    ./editor.nix
    ./gaming.nix
    ./ghostty.nix
    ./obsidian.nix
    ./taltech-vpn.nix
    ./vcs.nix
  ];
}
