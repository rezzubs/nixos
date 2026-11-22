# Common toggles for desktop systems.
{ ... }: {
  imports = [
    ./base.nix
    ../gnome.nix
  ];

  home-manager.users.rezzubs.imports = [ ../../home/profiles/desktop.nix ];

  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    flatpak.enable = true;
  };
}
