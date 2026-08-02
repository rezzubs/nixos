{
  config,
  lib,
  ...
}: {
  options.custom.wayland.enable = lib.mkEnableOption "common wayland graphical session options";

  config = lib.mkIf config.custom.wayland.enable {
    services.pipewire.enable = true;
  };
}
