{
  config,
  lib,
  pkgs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.sudo.enable = false;
  security.doas.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Tallinn";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.flatpak.enable = true;

  hardware.uinput.enable = true;
  services.kanata = {
    enable = true;
    keyboards.default.configFile = ./kanata.kbd;
  };

  programs.neovim.defaultEditor = true;

  programs.zsh.enable = true;
  users.users.rezzubs = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs;
    [
      hello
      alacritty
      git
      gnome-software
      gnome-tweaks
      nautilus
      neovim
      stow
      wl-clipboard
      zellij
    ]
    ++ (with pkgs.gnomeExtensions; [
      alphabetical-app-grid
      bing-wallpaper-changer
      dash-to-dock
      focus-changer
      rounded-window-corners-reborn
    ]);

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  services.xserver = {
    desktopManager.gnome = {
      enable = true;
    };

    displayManager.gdm.enable = true;
  };
  services.gnome.core-utilities.enable = false;

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
  system.stateVersion = "24.11"; # Did you read the comment?
}
