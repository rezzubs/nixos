{config, ...}: {
  sops.secrets = {
    # dns write access token
    "ddclient/cloudflare_api_token" = {};
  };

  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    usev4 = "webv4, webv4=ipv4.icanhazip.com";
    zone = "rezzubs.xyz";
    username = "token";
    passwordFile = config.sops.secrets."ddclient/cloudflare_api_token".path;
    domains = [
      "rezzubs.xyz"
      "cloud.rezzubs.xyz"
      "grafana.rezzubs.xyz"
      "immich.rezzubs.xyz"
      "mc.rezzubs.xyz"
      "vikunja.rezzubs.xyz"
      "budget.rezzubs.xyz"
      "rss.rezzubs.xyz"
    ];
    extraConfig = "ttl=1";
  };

  systemd.services.ddclient = {
    after = ["sops-nix.service"];
    wants = ["sops-nix.service"];
  };
}
