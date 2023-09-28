{ config, pkgs, lib, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
  ];
  nix = {
    settings = {
      trusted-users = [ "@wheel" "root" "nix-ssh" ];
      auto-optimise-store = true;
    };
    package = pkgs.nixUnstable;
    extraOptions =
      let empthy_registry = builtins.toFile "empty-flake-registry.json" ''{"flakes";[],"version":2}''; in
      ''
        experimental-features = nix-command flakes
        flake-registry = ${empty_registry}
        builders-use-substituetes = true
      '';
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };
}
