{ config, pkgs, ... }:

{
  # Define normal user
  users.users.katiko = {
    isNormalUser = true;
    description = "Katiko"; # optional but nice to have
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];

    packages = with pkgs; [
      # Essentials
      firefox
      nushell
      starship
      fzf
      fd
      bat
      bottom
      neofetch
      gzip
      neovim
      ripgrep
      tree-sitter
      zed-editor
      zoxide
      easyeffects
      wl-clipboard
      discord
      cliphist
      lsd
      spotify
      networkmanagerapplet
      gnumake
      clang-tools
      zip
      unzip
      tree
      telegram-desktop
      brightnessctl

      # Dev & language tooling
      python312
      python312Packages.pip
      python312Packages.python-lsp-server
      pyright
      gcc
      lua
      luajit
    ];
  };
}

