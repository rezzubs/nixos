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
    domains =
      builtins.map
      (subDomain: subDomain + ".rezzubs.xyz")
      [
        "budget"
        "cloud"
        "immich"
        "jellyfin"
        "kavita"
        "mc"
        "rezzubs"
      ];
    extraConfig = "ttl=1";
  };

  systemd.services.ddclient = {
    after = ["sops-nix.service"];
    wants = ["sops-nix.service"];
  };
}
