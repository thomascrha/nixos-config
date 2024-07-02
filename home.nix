{ config, pkgs, ... }:

{
  home.username = "tcrha";
  home.homeDirectory = "/home/tcrha";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-completions
    pkgs.zsh-pure-prompt
    pkgs.zsh-nvm

    pkgs.neovim
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.fd
    pkgs.fzf
    pkgs.bat
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # zshrc + zimfw
    ".zshrc".source = ./dotfiles/.zshrc;
    ".zimrc".source = ./dotfiles/.zimrc;
    ".p10k.zsh".source = ./dotfiles/.p10k.zsh;

    # neovim
    ".config/nvim/lua".source = ./dotfiles/.config/nvim/lua;
    ".config/nvim/init.lua".source = ./dotfiles/.config/nvim/init.lua;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zsh.enable = true;
  programs.home-manager.enable = true;
}
