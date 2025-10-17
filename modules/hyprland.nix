{ config, pkgs, ... }:

{
  # Enable Hyprland (Wayland compositor)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable XDG desktop portals for Wayland (for file pickers, screenshots, etc.)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # enables Wayland mode for Electron apps
    # Uncomment if you lose your cursor in Hyprland
    # WLR_NO_HARDWARE_CURSORS = "1";
  };
}

