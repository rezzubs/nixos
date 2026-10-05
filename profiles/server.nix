{...}: {
  imports = [./universal.nix];

  services = {
    openssh = {
      # this is only for sshd, the client is enabled by default.
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    # Bans IPs with repeated failed ssh logins; the sshd jail is enabled by default.
    fail2ban = {
      enable = true;
      bantime-increment = {
        enable = true;
        maxtime = "1w";
      };
    };
  };
}
