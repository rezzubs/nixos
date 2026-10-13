{...}: {
  virtualisation.oci-containers.containers.kavita = {
    image = "docker.io/jvmilazz0/kavita:0.9.1";

    ports = [
      "127.0.0.1:20040:5000"
    ];

    volumes = [
      "/mnt/data/media:/media:ro"
      "/mnt/ssd/kavita/config:/kavita/config"
    ];
  };
}
