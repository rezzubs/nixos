{...}: let
  dataRoot = "/mnt/data/jellyfin";
in {
  virtualisation.oci-containers.containers.jellyfin = {
    image = "docker.io/jellyfin/jellyfin:12.1";

    ports = [
      "127.0.0.1:20030:8096"
    ];

    volumes = [
      "${dataRoot}/cache:/cache"
      "${dataRoot}/config:/config"
      "${dataRoot}/media:/media:ro"
    ];
  };
}
