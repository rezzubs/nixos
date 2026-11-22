{ inputs, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    # Home modules declare their own nixpkgs config (like unfree packages
    # they accept), which only applies to a home-manager owned instance.
    # This also keeps the home side behaving the same as standalone
    # home-manager on non-NixOS hosts.
    useGlobalPkgs = false;
    # Install home.packages through users.users.<name>.packages, so they live
    # in the system closure instead of a separate nix profile.
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
