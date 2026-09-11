# 🐈‍⬛ HPC server
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/desktop.nix
  ];

  custom.kde.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  environment.systemPackages = with pkgs; [
    distrobox
    nvtop
    uv
  ];

  fileSystems = {
    "/".options = ["compress=zstd"];
    "/home".options = ["compress=zstd"];
    "/nix/store".options = ["compress=zstd" "noatime"];
  };

  hardware = {
    # Use the open source kernel modules
    nvidia.open = true;
  
    # GPU access in distrobox/containers.
    nvidia-container-toolkit.enable = true;
  };


  networking.hostName = "shadow";

  services = {
    xserver.videoDrivers = [
      # The proprietary driver for the 4090
      "nvidia"
    ];
  };

  users.users = {
    harshit = {
      isNormalUser = true;
      description = "Harshit Gupta";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBBUnYbIv10UZRh2JSBXl+hyAfu6IRrvX03+tJh59NJM harshit.gupta@taltech.ee"
      ];
    };

    kyrylo = {
      isNormalUser = true;
      description = "Kyrylo Nazarevych";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrZzZR59e+RaDx96gmSXlTg28Lu29Y3Tuj6QaH4pyi1 kyrylo.nazarevych@taltech.ee"
      ];
    };

    mojtaba = {
      isNormalUser = true;
      description = "Mohammad Hasan (Mojtaba) Ahmadilivani";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4JeTW8RpjVZftoW7lArHbfTzLXI2oUeZMXzwXsKeR9+Bd33wA+9KXWF1uMhwKttNcUE/Uh3079T9irm2wQ+zO1s5bI67zzgXCV4/KlLl4tlrKJSiUpNCmK7ExdNJWlf91FUpx/Fi/8Qygieh9N97YE7GpfLBpk6NOEbe7Wl721Pz5SZyM4CZY0M4ZjzAyiq2/uKqjVg7R1IlczBLVHBGr5UM6tQ68N5tziK6Gj23IPLbFNEf3YsU4Rscpmc+qKjGBQgf1AoAhoXOuuRXTAH30qxObd2EWo0gR8KO0FZdJJj6evLTVZmPDXuRzpVP+Dq7t/kQKJqPsf7VdFUT6xPGU7J0EVw8hNeaOWpAwZviY2EJWAENPK8ngz5IVRNmFWdWmG9EUO9x7PZsekIjrIn9y41fa2ZLLF/BY+Umc+zajqIv/k/q94fvo0/vf3lodWv8+wtO3f/mZoZKMvzzwbizc87mNfxa9qB8WSf3iaC+vDn4b7YuLH9d7TFMxa7EzwTM= mojtaba@krevett"
      ];
    };

    samiel = {
      isNormalUser = true;
      description = "Sven-Markus Loorits";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjlJjHkFg0HoYZSwHzZY/O2Llfo3931SGoFv+26PtoU rex.samiel@gmail.com"
      ];
    };
  };

  # podman for distrobox
  virtualisation.podman.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
