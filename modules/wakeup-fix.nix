{
  config,
  lib,
  ...
}: {
  options.custom.wakeupFix.enable = lib.mkEnableOption "Fix suspend on Gigabyte motherboards";

  config = lib.mkIf config.custom.wakeupFix.enable {
    systemd.services.wakeupFix = {
      description = "Fix suspend on Gigabyte motherboards";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";
      };
    };
  };
}
