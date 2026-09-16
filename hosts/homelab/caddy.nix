{...}: {
  # Reverse proxy in front of the various services.
  services.caddy = {
    enable = true;

    # /web/admin is prohibited - can only access it locally / via SSH tunneling.
    virtualHosts."cloud.rezzubs.xyz".extraConfig = ''
      handle /dav* {
        reverse_proxy 127.0.0.1:20001
      }

      handle /web/admin* {
        respond 403
      }

      handle {
        reverse_proxy 127.0.0.1:20000
      }
    '';

    # https://actualbudget.org/docs/config/reverse-proxies/#caddy
    virtualHosts."budget.rezzubs.xyz".extraConfig = ''
      encode gzip zstd
      reverse_proxy 127.0.0.1:20010
    '';

    virtualHosts."immich.rezzubs.xyz".extraConfig = ''
      reverse_proxy 127.0.0.1:20020
    '';

    virtualHosts."jellyfin.rezzubs.xyz".extraConfig = ''
      reverse_proxy 127.0.0.1:20030
    '';
  };

  # Caddy binds to these ports
  networking.firewall = {
    allowedTCPPorts = [80 443];
    allowedUDPPorts = [443]; # HTTP/3
  };
}
