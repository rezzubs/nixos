{
  config,
  lib,
  ...
}: {
  imports = [
    ./bootloader.nix
    ./editor.nix
    ./kde.nix
    ./niri.nix
    ./nix.nix
    ./steam.nix
    ./swap.nix
    ./users.nix
    ./wakeup-fix.nix
    ./wayland.nix
  ];
}
