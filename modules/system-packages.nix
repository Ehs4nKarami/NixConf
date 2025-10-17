{ config, pkgs, ... }:

{
  # System-wide packages (available for all users)
  environment.systemPackages = with pkgs; [
    wget              # Download tool
    git               # Version control
    hyprland          # Wayland compositor
    waybar            # Status bar
    rofi-wayland      # App launcher
    alacritty         # Terminal emulator
    swww              # Wallpaper daemon
    tmux              # Terminal multiplexer
    mpv               # Video player
    oculante          # Image viewer (nice pick!)
    swaylock-effects  # Lock screen
    gtk3              # GTK runtime support
  ];

  # Allow swaylock-effects to authenticate correctly
  security.pam.services.swaylock = {
    # Optional but recommended for smoother unlock experience
    text = ''
      auth include login
    '';
  };
}

