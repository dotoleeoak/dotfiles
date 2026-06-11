{ config, pkgs, ... }:

let
  hmDir = "${config.home.homeDirectory}/.config/home-manager";
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.stateVersion = "25.11";

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

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
    xxh
    yazi
    zoxide
    zsh

    awscli2
    bazelisk
    kubectl
    nixfmt
    pipx
    pnpm
    prettier
    pyrefly
    pyright
    ruff
    stylua
    typescript-language-server
    uv
    yaml-language-server
    yarn
  ];

  home.file = {
    ".config/nvim".source = mkSymlink "${hmDir}/nvim/";
    ".config/tmux".source = mkSymlink "${hmDir}/tmux/";
    ".claude/agents".source = mkSymlink "${hmDir}/claude/agents/";
    ".claude/settings.json".source = mkSymlink "${hmDir}/claude/settings.json";
    ".claude/CLAUDE.md".source = mkSymlink "${hmDir}/claude/CLAUDE.md";
    ".pi/agent/AGENTS.md".source = mkSymlink "${hmDir}/pi/AGENTS.md";
    ".pi/agent/settings.json".source = mkSymlink "${hmDir}/pi/settings.json";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      fetch.prune = true;
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
      format = "$directory$git_branch$git_status$character";
      right_format = "$time";
      time = {
        disabled = false;
        time_format = "%T";
        format = "[$time]($style)";
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      git_status = {
        ignore_submodules = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      bindkey -v

      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d ''' cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';

    shellAliases = {
      bazel = "bazelisk";
      ceph = "podman run -it --rm -v ~/.ceph:/etc/ceph quay.io/ceph/ceph:v20 ceph";
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
