{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot = {
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" "exfat" "vfat" ];

    loader = {
      timeout = 10;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Enable flakes and modern Nix features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    trusted-users = [ "root" "katiko" ];  # your username
    substituters = [ "https://cache.nixos.org/" ];
  };

  # Kernel configuration
  # Note: linuxPackages_6_12 may not exist yet if you're on 24.05 stable.
  # You can use pkgs.linuxPackages_latest instead.
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # CPU microcode
  # Uncomment the one matching your CPU
  hardware.cpu.amd.updateMicrocode = true;
  # hardware.cpu.intel.updateMicrocode = true;

  hardware.enableRedistributableFirmware = true;

  # Thermal & power management
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    # Example optional tuning:
    # settings = {
    #   CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #   CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    # };
  };

  # SSD optimization
  services.fstrim.enable = true;

  # Networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
    # You could also add:
    # extraHosts = ''
    #   1.1.1.1 cloudflare-dns
    #   8.8.8.8 google-dns
    # '';
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Time, locale, and console
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Tehran";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
}

