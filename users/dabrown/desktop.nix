{ config, lib, pkgs, inputs, ... };

{
  imports = [
    ./modules/nnn.nix
    ./modules/kitty.nix
  ];

  home = {
    packages = with pkgs; [
      inkscape
      gimp
      pavucontrol
      betterbird
    ];
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = {
      name = "adwaita-dar";
      package = pkgs.adwaita-qt;
    };
  };

  gtk = {
    enable = true;
    theme.package = pkgs.arc-theme;
    theme.name = "Arc-Dark";;
    iconTheme.package = pkgs.arc-icon-theme;
    iconTheme.name = "Arc";
  };

  xdg.enable = true;
};
