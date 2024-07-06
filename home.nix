{ config, pkgs, ... }:

{
  home.username = "tcrha";
  home.homeDirectory = "/home/tcrha";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neovim
    git
    curl
    wget
    gnumake
    fzf
    ripgrep
    fd
    python3
    luarocks
    lua
    gcc
    unzip
    zip
    nodejs
    firefox
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plalet
  home.file =   {
    # zshrc + zimfw
    ".zshrc".source = ./dotfiles/.zshrc;
    ".zimrc".source = ./dotfiles/.zimrc;
    ".zshenv".source = ./dotfiles/.zshenv;
    ".p10k.zsh".source = ./dotfiles/.p10k.zsh;

    # neovim
    ".config/nvim/lua".source = ./dotfiles/.config/nvim/lua;
    ".config/nvim/init.lua".source = ./dotfiles/.config/nvim/init.lua;

    # sway
    ".config/sway".source = ./dotfiles/.config/sway;

    # waybar
    ".config/waybar".source = ./dotfiles/.config/waybar;

    # wezterm
    ".config/wezterm".source = ./dotfiles/.config/wezterm;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

}
