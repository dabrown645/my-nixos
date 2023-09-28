{ config, lib, pkgs, ... }:
  { programs.kitty = {
    enable = true;
    font = {
      name = "Terminus (TTF) Bold";
      package = pkgs.terminus_font_ttf; size = 15;
    };
    settings = {
      enable_audio_bell = false;
      copy_on_select = "yes";
    };
    extraConfig = ''
      map ctrl+shift+plus change_font_size all +1.5
      map ctrl+shift+minus change_font_size all -1.5
      allow_remote_control no
      background            #000000
      foreground            #e9e9e9
      cursor                #e9e9e9
      selection_background  #424242
      selection_foreground  #000000
      color0                #000000
      color8                #000000
      color1                #d44d53
      color9                #d44d53
      color2                #b9c949
      color10               #b9c949
      color3                #e6c446
      color11               #e6c446
      color4                #79a6da
      color12               #79a6da
      color5                #c396d7
      color13               #c396d7
      color6                #70c0b1
      color14               #70c0b1
      color7                #fffefe
      color15               #fffefe
    '';
  };
};
