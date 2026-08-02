{
  config,
  lib,
  ...
}: {
  options.custom.steam.enable = lib.mkEnableOption "enable steam";

  config = lib.mkIf config.custom.steam.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
      ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
