# System specific configuration
{
  ...
}:
{
  # This is a fix for the Gigabyte B550M Aorus Pro-P which doesn't like to
  # suspend otherwise.
  systemd.services.gpp0-wakeup = {
    description = "Enable wake from GPP0 at boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
    };
  };
}
