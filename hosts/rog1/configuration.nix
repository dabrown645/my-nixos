{ config, pkgs, inputs, ... }:

{
  imports = with inputs.self.nixosModules; [
    ./hardware-configuration.nix
    users-davidbrown
    profiles-wireless
    profiles-pipewire
    mixins-common
    mixins-fonts
    mixins-bluetooth
    editor-nvim
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = import "${inputs.self}/users";
    extraSpecialArgs = {
      inherit inputs;
      headless = false;
    };
  };

  nix = {
    # from flake-utils-pluse
    generateNixPathFromInputs = true;
    generateRegistryFromInputs = true;
    linkInputs = true;
    '
  };

  networking = {
    firewall {
      # Syncthing ports
      allowTCPPorts = [ 22000 ];
      allowUDPPorts = [ 21027 22000 ];
    };
    hostName = "rog1";
    # use  'head -c4 /dev/urandom | od -A none -t x4' to generate a unique hostId
    hostid = "47867bd9";
    useNetworkd = true;
    wireless = {
      userControlled.enable = true;
      enable = true;
      interfaces = [ "wlp3s0" ];
    };
    useDHCP = false;
    interfaces = {
      "enp0s31f6".useDHCP = true;
      "wlp3s0".useDHCP = true;
    };
  };

  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        PCIE_ASPM_ON_BAT = "powersupersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_MAX_PERF_ON_AC = "100";
        CPU_MAX_PERF_ON_BAT = "30";
        STOP_CHARGE_THRESH_BAT1 = "95";
        STOP_CHARGE_THRUSH_BAT0 = "95";
      };
    };
    logind.killUserProcesses = true;
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-=Terminus16";
    keyMap = "us";
  };

  time.timeZone = "America/Los_Angles";
  location.provider = "geoclue2";

  hardware = {
    opengl.enable = true;
    opengl.extraPackages = with pkgs; [
      vulnan-loader
      vulkan-validation-layers
      vulkan-extension-layer
      vulkan-tools
    ];
    trackpoint = {
      enable = true;
      sensitivity = 255;
    };
  };

  environment.systemPackages = with pkgs; [
    bat
    brave
    eza
    git
    gnumake
    neovim
    wget
  ];

  system.stateVersion = "23.11";
}
