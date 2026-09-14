{
  config,
  pkgs,
  ...
}: let
  minecraftCompose = "/etc/compose/minecraft/compose.yaml";
in {
  sops = {
    secrets = {
      # the encryption password used for the borgbase repositories.
      "borgmatic/borgbase_encryption" = {};
      # The ssh private key used for pushing to borgbase
      "borgmatic/ssh_key" = {};
    };

    templates."borgmatic.env" = {
      path = "/run/secrets-rendered/borgmatic.env";
      mode = "0400";
      content = ''
        BORGBASE_ENCRYPTION=${config.sops.placeholder."borgmatic/borgbase_encryption"}
      '';
    };
  };

  services.borgmatic = let
    commonOptions = {
      compression = "zstd";
      recompress = "if-different";

      encryption_passphrase = "\${BORGBASE_ENCRYPTION}";

      keep_daily = 7;
      keep_monthly = 6;
      keep_weekly = 4;
      keep_yearly = 0;

      ssh_command = "ssh -i ${config.sops.secrets."borgmatic/ssh_key".path}";
    };
  in {
    enable = true;
    configurations = {
      minecraft =
        commonOptions
        // {
          source_directories = ["/mnt/data/minecraft"];
          repositories = [
            {
              path = "ssh://sll8t42w@sll8t42w.repo.borgbase.com/./repo";
              label = "minecraft-borgbase";
            }
          ];
          archive_name_format = "minecraft-{now:%Y-%m-%dT%H:%M:%S}";
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

      immich =
        commonOptions
        // {
          source_directories = ["/mnt/data/immich"];
          exclude_patterns = [
            "/mnt/data/immich/thumbs"
            "/mnt/data/immich/encoded-video"
          ];

          repositories = [
            {
              path = "ssh://o4xo5zyz@o4xo5zyz.repo.borgbase.com/./repo";
              label = "immich-borgbase";
            }
          ];

          archive_name_format = "immich-{now:%Y-%m-%dT%H:%M:%S}";
        };
    };
  };

  systemd.services.borgmatic = {
    serviceConfig.EnvironmentFile = config.sops.templates."borgmatic.env".path;
    # The module's unit PATH doesn't include /run/current-system/sw/bin, so
    # the minecraft before/after hooks' `docker compose` calls can't find docker.
    path = [pkgs.docker];
    after = ["sops-nix.service"];
    wants = ["sops-nix.service"];
  };

  # BorgBase fronts every repo with the same SSH gateway - one host key entry
  # covers both o4xo5zyz (immich) and sll8t42w (minecraft), verified via
  # ssh-keyscan against both subdomains (identical key on each).
  programs.ssh.knownHosts."repo.borgbase.com" = {
    hostNames = ["o4xo5zyz.repo.borgbase.com" "sll8t42w.repo.borgbase.com"];
    publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMS3185JdDy7ffnr0nLWqVy8FaAQeVh1QYUSiNpW5ESq";
  };
}
