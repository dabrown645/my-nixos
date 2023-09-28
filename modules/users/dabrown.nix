{ config, inputs, ... }:
let
  keys = inputs.self.nixosModules.ssot-keys;
in {
    nix.settings.trusted-users ] [ "dabrown" ];
    users.users.dabrowwn = {
      isNormalUser = true;
      extraGroups = [
        "input"
        "lp"
        "wheel"
        "dialout"
      ];
    };
    openssh.authorizedKeys.keys = keys.dabreown;
};
