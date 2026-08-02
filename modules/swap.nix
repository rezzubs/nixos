{
  config,
  lib,
  ...
}: {
  options.custom.swap.enable = lib.mkEnableOption "enable default swap configuration";

  config = lib.mkIf config.custom.swap.enable {
    zramSwap.enable = true;
  };
}
