#!/usr/bin/env bash

BASEDIR=$(realpath $(dirname $0))
echo "BASEDIR: $BASEDIR"

# Add entry script
grep -q "$BASEDIR/myrc.sh" ~/.bashrc || echo "source ~/.jaemin/myrc.sh" >>~/.bashrc

# Install homebrew (Mac only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install neovim
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim
fi

ln -sf ~/.config/nvim $BASEDIR/nvim

# TODO: install fzf
# TODO: install & setup tmux

ln -sf ~/.config/tmux $BASEDIR/tmux

# TODO: install lazygit

##### TMUX #####

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins
git clone https://github.com/wfxr/tmux-power ~/.tmux/plugins/tmux-power
git clone https://github.com/wfxr/tmux-net-speed ~/.tmux/plugins/tmux-net-speed
