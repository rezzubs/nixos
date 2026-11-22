# Fix suspend on Gigabyte motherboards.
{ ... }:
{
  systemd.services.wakeupFix = {
    description = "Fix suspend on Gigabyte motherboards";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
      ExecStop = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
    };
  };
}
