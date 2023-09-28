{
  description = "Matthew's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2305 = "github:nixoss/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:/nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {
    {
      self,
      nixpkgs,
      home-manager,
      nixpkgs2305,
      nixos-hardware,
      impermanence,
      ...
    } @ inputs: {
        nixosModules = import ./modules { lib = nixpkgs.lib; };
        nixosConfigurations = {
          rog1 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            moddules = [
              ./hosts/rog1/configuration.nix
              home-manager.nixosModules.home-manager
            ];
            specialArgs = { inherit inputs; };
          };
        };
      }
  };
}
