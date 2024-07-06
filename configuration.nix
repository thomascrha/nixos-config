# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./sway.nix
  ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    grub.useOSProber = true;
  };

  # ENABLE TRIM on bare metal
  # services.fstrim.enable = lib.mkDefault true;

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enableCompletion = false;
  programs.zsh.enable = true;

  networking.hostName = "tcrha-nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  users.users.tcrha = {
    isNormalUser = true;
    description = "tcrha";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    pkgs.home-manager
  ];

  services.gnome.gnome-keyring.enable = true;

  # docker
  virtualisation.docker.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.extraConfig = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      };
    };
  };

  hardware.bluetooth.enable = true;

  environment.sessionVariables = rec {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XCURSOR_SIZE = "24";
  };

  users.users.simon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  fonts.packages = with pkgs; [
    font-awesome
      powerline-fonts
      powerline-symbols
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
  services.printing.enable = true;
}
