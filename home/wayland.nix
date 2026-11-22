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

  # Without a cursor theme the compositor falls back to a tiny built-in cursor
  # that ignores output scaling. Sway picks the theme up from the XCURSOR_*
  # variables this sets.
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
