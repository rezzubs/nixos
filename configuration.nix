# System agnostic configuration
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  environment = {
    sessionVariables = {
      EDITOR = "neovim";
    };

    systemPackages =
      with pkgs;
      [
        alacritty
        gcc
        git
        gnome-software
        gnome-tweaks
        htop
        lazygit
        nautilus
        stow
        wl-clipboard
        zellij
        fd
        ripgrep
      ]
      ++ (with pkgs.gnomeExtensions; [
        alphabetical-app-grid
        bing-wallpaper-changer
        blur-my-shell
        dash-to-dock
        focus-changer
        rounded-window-corners-reborn
      ])
      ++ (with pkgs-unstable; [
        neovim
        nerd-fonts.iosevka
      ]);
  };

  hardware.uinput.enable = true;

  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs = {
    gamescope.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nano.enable = false;

    zsh.enable = true;

    starship.enable = true;
  };

  security = {
    sudo.enable = false;
    doas.enable = true;
  };

  services = {
    # NOTE: Printer discovery
    # https://nixos.wiki/wiki/Printing
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    flatpak.enable = true;

    gnome.core-utilities.enable = false;

    kanata = {
      enable = true;
      keyboards.default.configFile = ./kanata.kbd;
    };

    libinput.enable = true;

    openssh.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    printing.enable = true;

    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm.enable = true;
    };
  };

  time.timeZone = "Europe/Tallinn";

  users.users.rezzubs = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  zramSwap.enable = true;

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
