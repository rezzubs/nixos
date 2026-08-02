{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./wayland.nix
  ];

  options.custom.niri = {
    enable = lib.mkEnableOption "enables the niri compositor";
    noctalia = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable options for noctalia capabilities";
    };
  };

  config = lib.mkIf config.custom.niri.enable (lib.mkMerge [
    {
      custom.wayland.enable = true;

      programs.niri.enable = true;

      environment.systemPackages = with pkgs; [
        # Xwayland support. Niri integrates it automatically.
        xwayland-satellite
        # programs.niri uses nautilus as the file picker by default.
        nautilus
      ];
    }
    (lib.mkIf config.custom.niri.noctalia {
      services = {
        power-profiles-daemon.enable = true;
        upower.enable = true;
      };

      hardware.bluetooth.enable = true;
    })
  ]);
}
