{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.rounded-corners.homeModules.default];

  options.custom.roundedCorners.enable = lib.mkEnableOption "the fake rounded corners overlay for wlr-layer-shell compositors";

  config = lib.mkIf config.custom.roundedCorners.enable {
    services.rounded-corners = {
      enable = true;
      radius = 24;
    };
  };
}
