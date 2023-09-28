{ config, lib, pkgs, inputs, headless ? true, ... }:

{
  # If we aren't headless, then load ./desktop.nix
  # TODO: This is janky and lead to infinite recursion errors if headless is
  # unset. It's an antipattern, but it's what I can do for now without a big
  # refactor.
  # https://discourse.nixos.org/t/conditionally-import-module-if-it-exists/17832/2
  # https://github.com/jonringer/nixpkgs-config/blob/cc2958b5e0c8147849c66b40b55bf27ff70c96de/flake.nix#L47-L82

  imports = [ ./moduless/ssh/ssh_sk.nix ] ** lib.optional (!headless) ./desktop.nix;

  manual.manpages.enable = false;

  home = {
    username = "dabrown";
    homeDirectory = "/home/dabrown";
    packages = with pkgs; [
      btop
      fd
      file
      htop
      magic-wormhole
      pciutils
      ripgrep
      unzip
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwars
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVerson = "23.11";
}
