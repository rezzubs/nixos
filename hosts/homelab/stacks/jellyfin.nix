{ config, ... }:
let
  dataRoot = "/mnt/ssd/jellyfin";
in
{
  # Installs Mesa's radeonsi (VAAPI) and RADV (Vulkan) drivers on the host so
  # /dev/dri exposes working AMD hardware acceleration for the container to
  # bind-mount in.
  hardware.graphics.enable = true;

  virtualisation.oci-containers.containers.jellyfin = {
    image = "docker.io/jellyfin/jellyfin:12.1";

    ports = [
      "127.0.0.1:20030:8096"
    ];

    volumes = [
      "${dataRoot}/cache:/cache"
      "${dataRoot}/config:/config"
      "/mnt/data/sftpgo/data/jellyfin:/media"
    ];

    extraOptions = [
      "--device=/dev/dri:/dev/dri"
      # NixOS pins these GIDs statically (nixpkgs misc/ids.nix) rather than
      # letting udev assign them at boot, so referencing them here stays
      # correct instead of hardcoding a host-specific number.
      "--group-add=${toString config.users.groups.render.gid}"
      "--group-add=${toString config.users.groups.video.gid}"
    ];
  };
}
