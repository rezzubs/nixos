{
  config,
  lib,
  pkgs,
  ...
}: let
  # Shared helper that determines the final service name.
  composeUnitName = name: "compose-${name}";

  # A systemd unit that brings up a docker compose stack and tears it down again
  # on stop, instead of that being a manual `docker compose` invocation.
  mkComposeService = {
    name,
    # The compose project's own directory. Passed as-is so it resolves to that
    # directory's own store path - see WorkingDirectory below for why that
    # matters.
    dir,
    # Sops-rendered dotenv file, if this stack needs secrets.
    envFile ? null,
    # Stack names (not unit names) this one must come up after - e.g. joining
    # caddy's `proxy` docker network requires caddy to have created it first.
    dependsOnStacks ? [],
  }: let
    # --env-file feeds compose's own `${VAR}` substitution in compose.yaml
    # (image tags, volume paths, ...). Distinct from `env_file:` inside the
    # compose file itself, which only sets the *container's* environment.
    composeCmd = "${pkgs.docker}/bin/docker compose" + lib.optionalString (envFile != null) " --env-file ${envFile}";
    dependsOnUnits = map (n: "${composeUnitName n}.service") dependsOnStacks;
  in {
    description = "docker compose stack: ${name}";
    after =
      ["docker.service" "network-online.target"]
      # sops-nix.service renders envFile; must exist before compose reads it.
      ++ lib.optional (envFile != null) "sops-nix.service"
      ++ dependsOnUnits;
    wants = ["network-online.target"] ++ lib.optional (envFile != null) "sops-nix.service";
    # `requires`, unlike `wants`, fails this unit if the dependency fails -
    # correct here since without docker or the proxy network this stack
    # can't do anything anyway.
    requires = ["docker.service"] ++ dependsOnUnits;
    # start automatically on boot
    wantedBy = ["multi-user.target"];
    # puts `docker` on PATH for the bare command below
    path = [pkgs.docker];
    serviceConfig = {
      # `docker compose up -d` exits once containers are detached - this
      # isn't a long-running process for systemd to supervise directly.
      Type = "oneshot";
      # ...but the unit should still read as "active", not "inactive", while
      # those containers keep running.
      RemainAfterExit = true;
      # A store path. This unit's own text (this line) changes whenever the
      # stack's compose.yaml does (because the store object's content hash
      # will change). This makes `nixos-rebuild switch` restart a stack whose
      # compose.yaml changed - handled by ordinary unit-change detection - no
      # separate restartTriggers list to keep in sync.
      WorkingDirectory = dir;
      # --remove-orphans stops containers for services no longer in compose.yaml
      # (still scoped to that file, won't touch services from other stacks).
      # Usually redundant, since ExecStop already tore those down against the
      # file version that still declared them - it matters for cases with no
      # such preceding stop: first adoption of this unit, a plain reboot, or
      # ExecStop having failed.
      ExecStart = "${composeCmd} up -d --remove-orphans";
      ExecStop = "${composeCmd} down";
      # Pulling images on first start can take a while.
      TimeoutStartSec = "infinity";
    };
  };

  # Turns a plain list of stack definitions (mkComposeService's arguments) into
  # the systemd.services attrset, so a stack is named once (as `name`) rather
  # than also having to be spelled out as an attrset key.
  mkComposeServices = stacks:
    lib.listToAttrs (map (stack: {
        name = composeUnitName stack.name;
        value = mkComposeService stack;
      })
      stacks);
in {
  sops = {
    secrets = {
      "immich/db_password" = {};
    };

    templates."immich.env" = {
      path = "/run/secrets-rendered/immich.env";
      mode = "0400";
      # A secret value changing doesn't change this template's rendered path,
      # so it wouldn't otherwise be noticed as a reason to restart the compose
      # unit.
      restartUnits = ["${composeUnitName "immich"}.service"];
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

  systemd.services = mkComposeServices [
    {
      name = "caddy";
      dir = ./caddy;
    }
    {
      name = "minecraft";
      dir = ./minecraft;
    }
    {
      name = "actual-budget";
      dir = ./actual-budget;
      dependsOnStacks = ["caddy"];
    }
    {
      name = "sftpgo";
      dir = ./sftpgo;
      dependsOnStacks = ["caddy"];
    }
    {
      name = "immich";
      dir = ./immich;
      envFile = config.sops.templates."immich.env".path;
      dependsOnStacks = ["caddy"];
    }
  ];

  virtualisation.docker.enable = true;
}
