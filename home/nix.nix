{
  config,
  lib,
  ...
}: {
  options.custom.unfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "Names of unfree packages allowed to be installed.";
  };

  config.nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) config.custom.unfreePackages;
}
