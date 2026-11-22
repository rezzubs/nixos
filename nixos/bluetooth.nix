# Tools for hosts with bluetooth. Hosts enable `hardware.bluetooth` themselves.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.hardware.bluetooth.enable {
    # bluetooth TUI
    environment.systemPackages = [ pkgs.bluetui ];
  };
}
