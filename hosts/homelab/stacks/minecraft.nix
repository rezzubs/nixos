{
  # The attribute name after `containers` sets the final container name.
  # `backup.nix` targets it by that same name via `docker exec`, so update both
  # together.
  virtualisation.oci-containers.containers.minecraft = {
    image = "docker.io/itzg/minecraft-server";

    ports = [
      "25565:25565"
    ];

    environment = {
      EULA = "TRUE";
      MAX_MEMORY = "8G";
    };

    volumes = [
      "/mnt/data/minecraft:/data"
    ];
  };
}
