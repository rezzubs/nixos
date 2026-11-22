{ ... }: {
  imports = [
    ../shared/unstable-packages.nix
    ./bootloader.nix
    ./editor.nix
    ./gnome.nix
    ./home-manager.nix
    ./nix.nix
    ./steam.nix
    ./swap.nix
    ./users.nix
    ./wakeup-fix.nix
    ./wayland.nix
  ];
}
