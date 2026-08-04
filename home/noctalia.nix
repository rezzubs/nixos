{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.noctalia.homeModules.default];

  options.custom.noctalia = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "use the noctalia shell";
    };
  };

  config = lib.mkIf config.custom.noctalia.enable {
    programs.noctalia = {
      enable = true;
      # Starts automatically with graphical session.
      systemd.enable = true;

      settings = {
        config_version = 11;

        backdrop.enabled = true;

        bar.default = {
          center = ["clock" "weather"];
          margin_ends = 0;
          padding = 12;
          position = "left";
          radius = 18;
          radius_bottom_left = 0;
          radius_top_left = 0;
          start = [
            "launcher"
            "workspaces"
            "cpu"
            "sysmon"
            "ram"
          ];
          end = [
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "battery"
            "session"
          ];
          thickness = 36;
          widget_spacing = 12;
        };

        desktop_widgets.enabled = false;

        idle = {
          behavior_order = ["screen-off" "lock" "lock-and-suspend"];
          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 660.0;
            };
            "lock-and-suspend" = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 900.0;
            };
            "screen-off" = {
              action = "screen_off";
              enabled = true;
              timeout = 600.0;
            };
          };
        };

        location.address = "Tallinn";

        nightlight = {
          enabled = true;
          temperature_day = 6500;
          temperature_night = 4500;
        };

        shell = {
          launch_apps_as_systemd_services = true;
          panel.open_near_click_control_center = true;
        };

        theme = {
          builtin = "Catppuccin";
          templates = {
            enable_builtin_templates = false;
            enable_community_templates = false;
          };
        };

        wallpaper.directory = "/home/rezzubs/Pictures/wallpaper";

        widget = {
          cpu.label_show_units = false;
          ram.label_show_units = false;
          sysmon = {
            label_show_units = false;
            stat = "gpu_usage";
          };
          workspaces = {
            active_pill_size = 2.0;
            show_labels = false;
          };
        };
      };
    };
  };
}
