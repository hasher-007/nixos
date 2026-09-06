{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eiko"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.gnome.core-apps.enable = false;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "purple";
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "caps:swapescape" ];
        };
      };
    }
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
  ];

  environment.variables = {
      XCURSOR_SIZE = 32;
      XCURSOR_THEME = "macOS";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.therootdaemon = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "therootdaemon";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    zsh
    neovim
    starship
    python313
    python313Packages.pynvim
    fzf
    ripgrep
    oh-my-posh
    tldr
    tree
    tmux
    lua
    luarocks
    stylua
    lua-language-server
    ghostty
    git
    nautilus
    gnome-tweaks
    go
    gofumpt
    gopls
    nodejs
    apple-cursor
    papirus-icon-theme
  ];
  
  fonts.packages = with pkgs; [
    maple-mono.NF-unhinted
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
