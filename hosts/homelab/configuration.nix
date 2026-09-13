{
  config,
  lib,
  ...
}: let
  minecraftCompose = "/etc/compose/minecraft/compose.yaml";
in {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/server.nix
  ];

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/mnt/data".options = ["compress=zstd"];
    "/nix/store".options = ["compress=zstd" "noatime"];
  };

  networking.hostName = "homelab";

  # Stacks are copied into the store. `nixos-rebuild switch` is the only thing
  # that can change what's actually deployed.
  environment.etc."compose/minecraft".source = ./minecraft;
  environment.etc."compose/immich".source = ./immich;
  environment.etc."compose/actual-budget".source = ./actual-budget;
  environment.etc."compose/caddy".source = ./caddy;
  environment.etc."compose/sftpgo".source = ./sftpgo;

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

    secrets = {
      # the encryption password used for the borgbase repositories.
      "borgmatic/borgbase_encryption" = {};
      # The borgbase repository used for minecraft
      "borgmatic/minecraft_repo" = {};
      # The ssh private key used for pushing to borgbase
      "borgmatic/ssh_key" = {};

      # dns write access token
      "ddclient/cloudflare_api_token" = {};

      "immich/db_password" = {};
    };

    templates = {
      "borgmatic.env" = {
        path = "/run/secrets-rendered/borgmatic.env";
        mode = "0400";
        content = ''
          MINECRAFT_BORGBASE=${config.sops.placeholder."borgmatic/minecraft_repo"}
          BORGBASE_ENCRYPTION=${config.sops.placeholder."borgmatic/borgbase_encryption"}
        '';
      };

      "immich.env" = {
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
  };

  services = {
    borgmatic = {
      enable = true;
      configurations = {
        minecraft = {
          source_directories = ["/mnt/data/minecraft"];
          repositories = [
            {
              path = "\${MINECRAFT_BORGBASE}";
              label = "minecraft-borgbase";
            }
          ];
          encryption_passphrase = "\${BORGBASE_ENCRYPTION}";
          compression = "zstd";
          recompress = "if-different";
          keep_daily = 7;
          keep_weekly = 4;
          keep_monthly = 6;
          keep_yearly = 0;
          statistics = true;
          archive_name_format = "minecraft-{now:%Y-%m-%dT%H:%M:%S}";
          ssh_command = "ssh -i ${config.sops.secrets."borgmatic/ssh_key".path}";
          commands = [
            {
              before = "repository";
              run = [
                "docker compose -f ${minecraftCompose} exec -T minecraft rcon-cli save-off"
                "docker compose -f ${minecraftCompose} exec -T minecraft rcon-cli save-all flush"
                "sleep 3"
              ];
            }
            {
              after = "repository";
              states = ["finish" "fail"];
              run = ["docker compose -f ${minecraftCompose} exec -T minecraft rcon-cli save-on"];
            }
          ];
        };
      };
    };

    ddclient = {
      enable = true;
      protocol = "cloudflare";
      usev4 = "webv4, webv4=ipv4.icanhazip.com";
      zone = "rezzubs.xyz";
      username = "token";
      passwordFile = config.sops.secrets."ddclient/cloudflare_api_token".path;
      domains = [
        "rezzubs.xyz"
        "cloud.rezzubs.xyz"
        "grafana.rezzubs.xyz"
        "immich.rezzubs.xyz"
        "mc.rezzubs.xyz"
        "vikunja.rezzubs.xyz"
        "budget.rezzubs.xyz"
        "rss.rezzubs.xyz"
      ];
      extraConfig = "ttl=1";
    };
  };

  systemd.services = {
    borgmatic = {
      serviceConfig.EnvironmentFile = config.sops.templates."borgmatic.env".path;
      after = ["sops-nix.service"];
      wants = ["sops-nix.service"];
    };

    ddclient = {
      after = ["sops-nix.service"];
      wants = ["sops-nix.service"];
    };
  };

  virtualisation.docker.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
