{
  config,
  lib,
  ...
}: {
  options.custom.users.enable = lib.mkEnableOption "add default users";

  config = lib.mkIf config.custom.users.enable {
    users.users.rezzubs = {
      extraGroups = ["wheel" "networkmanager"];
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKgY4pJwR2W3EDH0EJD0rTjWaxV434lsI4ri8FObMmvU rezzubs@elitebook"
      ];

      # Default password made with `mkpasswd`.
      hashedPassword = "$y$j9T$rSAmhALEjQsimEujes07J/$3R2HZFeM/EwaJOOZMzMZxRvEdRFVja3WWvOVYTKora3";
    };
  };
}
