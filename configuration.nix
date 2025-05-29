# System agnostic configuration
{
  pkgs,
  ...
}:
{
  boot = {
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
        distrobox
        fd
        fzf
        git
        htop
        lazygit
        nautilus
        neovim
        nerd-fonts.iosevka
        ripgrep
        stow
        wl-clipboard
        zellij
      ]
      ++ (with pkgs.kdePackages; [
        discover
      ]);
  };

  hardware.uinput.enable = true;

  networking.networkmanager.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise.automatic = true;

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

  };

  programs = {
    gamescope.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    kdeconnect.enable = true;

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

    fprintd.enable = true;

    gnome.core-apps.enable = false;

    kanata = {
      enable = true;
      keyboards.default.configFile = ./kanata.kbd;
    };

    libinput.enable = true;

    openssh.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };

    printing.enable = true;

    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"
    '';

    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  time.timeZone = "Europe/Tallinn";

  users = {
    defaultUserShell = pkgs.zsh;

    users.rezzubs = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
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
