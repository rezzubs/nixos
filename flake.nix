{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rounded-corners = {
      url = "github:rezzubs/wayland-rounded-corners";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For Framework 13 Pro modules
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      home-manager,
      nixos-hardware,
      nixpkgs,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        tower = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/tower/configuration.nix ];
        };

        elitebook = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/elitebook/configuration.nix ];
        };

        fw13 = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/fw13/configuration.nix
            nixos-hardware.nixosModules.framework-intel-core-ultra-series3
          ];
        };

        shadow = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/shadow/configuration.nix ];
        };

        homelab = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/homelab/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };
      };

      homeConfigurations = {
        "rezzubs@tower" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [ ./hosts/tower/home.nix ];
        };

        "rezzubs@elitebook" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [ ./hosts/elitebook/home.nix ];
        };

        "rezzubs@homelab" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [ ./hosts/homelab/home.nix ];
        };

        "rezzubs@fw13" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [ ./hosts/fw13/home.nix ];
        };

      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
