{ config, pkgs, ... }:

{
  # Enable PipeWire (modern replacement for PulseAudio)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # for 32-bit apps like Steam
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Disable the legacy PulseAudio daemon
  hardware.pulseaudio.enable = false;
}

