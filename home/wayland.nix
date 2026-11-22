# Tools shared by wayland sessions.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # clipboard access from the terminal
    wl-clipboard
    # media and hardware key bindings
    brightnessctl
    playerctl
  ];
}
