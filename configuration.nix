{ config, pkgs, ... }:

{
  imports =
    [
      ./modules/nvidia.nix
      ./hardware-configuration.nix
      ./modules/audio.nix
      ./modules/home-packages.nix
      ./modules/system.nix
      ./modules/system-packages.nix
      ./modules/hyprland.nix
    ];

  # CHANGE Garbage collection to free up space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # System state version
  system.stateVersion = "24.05"; 
}
