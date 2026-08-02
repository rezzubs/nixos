{
  config,
  lib,
  ...
}: {
  options.custom.nix.enable = lib.mkEnableOption "enable common nix config";

  config = lib.mkIf config.custom.nix.enable {
    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };

      optimise.automatic = true;

      settings.experimental-features = ["nix-command" "flakes"];
    };
  };
}
