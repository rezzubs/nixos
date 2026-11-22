{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "taltech-vpn" ''
      exec sudo ${pkgs.openfortivpn}/bin/openfortivpn vpn.taltech.ee:443 --saml-login "$@"
    '')
  ];
}
