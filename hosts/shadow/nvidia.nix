# Proprietary NVIDIA driver for the 4090.
{config, ...}: {
  nixpkgs.config.allowUnfreePackages = ["nvidia-x11"];

  hardware = {
    nvidia = {
      # Use the open source kernel modules
      open = true;

      # avoids a GTK dependency
      nvidiaSettings = false;

      # keeps the GPU initialized between jobs
      nvidiaPersistenced = true;
    };

    # GPU access in distrobox/containers.
    nvidia-container-toolkit.enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  programs.nix-ld.libraries = [
    # provides libcuda.so.1
    config.hardware.nvidia.package
  ];
}
