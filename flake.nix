{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  };

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        main = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs-unstable;
          };

          modules = [
            ./configuration.nix
            ./main/hardware-configuration.nix
            ./main/custom.nix
          ];
        };

        work-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs-unstable;
          };

          modules = [
            ./configuration.nix
            ./work-laptop/hardware-configuration.nix
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nixfmt-rfc-style
        ];
      };
    };
}
