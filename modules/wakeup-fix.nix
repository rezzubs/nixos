{
  config,
  lib,
  ...
}: {
  options.custom.wakeup-fix.enable = lib.mkEnableOption "Fix suspend on Gigabyte motherboards";

  config = lib.mkIf config.custom.wakeup-fix.enable {
    systemd.services.wakeup-fix = {
      description = "Fix suspend on Gigabyte motherboards";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
      };
    };
  };
}
