{ config, ... }:
{
  nix = {
    optimise.automatic = true;

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # A nicer frontend for rebuilds. `nh os switch` shows a package diff before
  # activating.
  programs.nh = {
    enable = true;
    flake = "${config.users.users.rezzubs.home}/nixos";

    # Replaces `nix.gc`. Unlike it, this also removes stale gc roots outside the
    # system profile (old user profiles, direnv shells).
    clean = {
      enable = true;
      dates = "weekly";
      # Keep a few generations even if all are older than 30 days, so a machine
      # that hasn't been rebuilt in a while still has something to roll back to.
      extraArgs = "--keep-since 30d --keep 3";
    };
  };
}
