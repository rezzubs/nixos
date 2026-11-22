# The sway compositor and system services setup.
{ ... }:
{
  imports = [ ./wayland.nix ];

  # NOTE: programs.sway already enables xdg-desktop-portal-wlr (screen capture)
  # and xdg-desktop-portal-gtk (file chooser).

  programs.sway = {
    enable = true;
    # The default bundle (foot, wmenu, ...) is replaced by the packages from the
    # home-manager module.
    extraPackages = [ ];
  };

  # Without a PAM service swaylock can't unlock the session.
  security.pam.services.swaylock = { };

  # Password prompts when GUI apps request privileged actions. Runs as a user
  # service with the graphical session, which sway starts through
  # /etc/sway/config.d.
  security.soteria.enable = true;

  # There is no display manager. Only the first login on tty1 starts the
  # compositor, other ttys stay usable as a fallback.
  programs.bash.loginShellInit = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      exec sway
    fi
  '';

  home-manager.users.rezzubs.imports = [ ../home/sway.nix ];
}
