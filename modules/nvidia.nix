{ config, pkgs, ... }:

{
  # Allow proprietary NVIDIA drivers
  nixpkgs.config.allowUnfree = true;

  # Enable X11 (even if you use Wayland, this provides fallback and utilities)
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # Enable OpenGL (needed for both X11 and Wayland compositors)
  hardware.graphics = {
  enable = true;
  enable32Bit = true;  # needed for Steam, Wine, etc.
  };

  # NVIDIA configuration
  hardware.nvidia = {
    modesetting.enable = true; # Required for Wayland + modern rendering

    # Power management (optional)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Use proprietary driver (open=false is safest right now)
    open = false;

    nvidiaSettings = true;

    # Recommended: match to stable version shipped with kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # PRIME setup (only if you have hybrid GPU)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # NOTE: These IDs must match your actual `lspci` output!
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";
    };
  };

  # Disable Nouveau to avoid conflicts
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Kernel parameters for stability (Wayland + Hyprland)
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];

  # Environment variables for Wayland/Electron apps
  environment.variables = {
    "GBM_BACKEND" = "nvidia-drm";
    "__GLX_VENDOR_LIBRARY_NAME" = "nvidia";
    "LIBVA_DRIVER_NAME" = "nvidia";
    "XDG_SESSION_TYPE" = "wayland";
    "WLR_NO_HARDWARE_CURSORS" = "1"; # helps prevent invisible cursor issue
  };
}

