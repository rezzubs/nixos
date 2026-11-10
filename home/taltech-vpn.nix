{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom.taltech-vpn.enable = lib.mkEnableOption "TalTech VPN script";

  config = lib.mkIf config.custom.taltech-vpn.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "taltech-vpn" ''
        exec sudo ${pkgs.openfortivpn}/bin/openfortivpn vpn.taltech.ee:443 --saml-login "$@"
      '')
    ];
  };
}
