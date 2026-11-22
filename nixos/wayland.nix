# Common options for wayland graphical sessions.
{ ... }:
{
  # Also provides wpctl for volume control through wireplumber.
  services.pipewire.enable = true;

  home-manager.users.rezzubs.imports = [ ../home/wayland.nix ];
}
