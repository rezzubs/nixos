{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
      nixos-hardware,
      nixpkgs,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkNixosSystem =
        modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit modules;
        };
    in
    {
      nixosConfigurations = {
        tower = mkNixosSystem [ ./hosts/tower/configuration.nix ];

        elitebook = mkNixosSystem [ ./hosts/elitebook/configuration.nix ];

        fw13 = mkNixosSystem [
          ./hosts/fw13/configuration.nix
          nixos-hardware.nixosModules.framework-intel-core-ultra-series3
        ];

        homelab = mkNixosSystem [
          ./hosts/homelab/configuration.nix
          sops-nix.nixosModules.sops
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;
    };
}
