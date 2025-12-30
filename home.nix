{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.username = "dotol";
  home.homeDirectory = "/Users/dotol";

  home.packages = with pkgs; [
    bitwarden-cli
    fd
    fzf
    gemini-cli
    gh
    git
    lazygit
    neovim
    ripgrep
    starship
    tmux
    tree
    zoxide
    zsh

    awscli2
    bazelisk
    kubectl
    uv
  ];

  home.file = {
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/Users/dotol/.config/home-manager/nvim";
    ".config/tmux".source =
      config.lib.file.mkOutOfStoreSymlink "/Users/dotol/.config/home-manager/tmux";
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = "bindkey -v";

    shellAliases = {
      bazel = "bazelisk";
      k = "kubectl";
      lg = "lazygit";
      tf = "terraform";
      vi = "nvim";
      vim = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "brew"
        "docker"
        "fzf"
        "git"
        "kubectl"
        "zoxide"
      ];
    };
  };
}
