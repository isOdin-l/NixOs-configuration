{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.isodin = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit nixpkgs-unstable;
      };

      modules = [
        ./nixos/configuration.nix
      ];
    };
  };
}