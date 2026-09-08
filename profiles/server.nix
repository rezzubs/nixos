{config}: {
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
  };
}
