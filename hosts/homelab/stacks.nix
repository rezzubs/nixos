{config, ...}: {
  sops = {
    secrets = {
      "immich/db_password" = {};
    };

    templates."immich.env" = {
      path = "/run/secrets-rendered/immich.env";
      mode = "0400";
      content = ''
        UPLOAD_LOCATION=/mnt/data/immich
        DB_DATA_LOCATION=/mnt/ssd/immich-postgres
        TZ=Europe/Tallinn
        IMMICH_VERSION=release
        DB_USERNAME=postgres
        DB_DATABASE_NAME=immich
        DB_PASSWORD=${config.sops.placeholder."immich/db_password"}
      '';
    };
  };

  # Stacks are copied into the store. `nixos-rebuild switch` is the only thing
  # that can change what's actually deployed.
  environment.etc."compose/minecraft".source = ./minecraft;
  environment.etc."compose/immich".source = ./immich;
  environment.etc."compose/actual-budget".source = ./actual-budget;
  environment.etc."compose/caddy".source = ./caddy;
  environment.etc."compose/sftpgo".source = ./sftpgo;

  virtualisation.docker.enable = true;
}
