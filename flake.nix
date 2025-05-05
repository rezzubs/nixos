{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      main = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./main/hardware-configuration.nix
        ];
      };
      work-laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./work-laptop/hardware-configuration.nix
        ];
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        nil
      ];
    };
  };
}
