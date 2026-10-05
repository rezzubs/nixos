{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    distrobox
  ];

  # podman for distrobox
  virtualisation.podman.enable = true;
}
