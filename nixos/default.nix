{ ... }: {
  imports = [
    ./bootloader.nix
    ./editor.nix
    ./gnome.nix
    ./nix.nix
    ./steam.nix
    ./swap.nix
    ./users.nix
    ./wakeup-fix.nix
    ./wayland.nix
  ];
}
