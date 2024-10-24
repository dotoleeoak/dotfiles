#!/usr/bin/env bash
set -x

BASEDIR=$(dirname $0)
ln -sf ~/.jaemin $BASEDIR

# Add entry script
grep -q "~/.jaemin/myrc.sh" ~/.bashrc || echo "source ~/.jaemin/myrc.sh" >>~/.bashrc

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
# TODO: install lazygit

# Load Wakatime API key
if [ ! -z WAKATIME_API ]; then {
    printf '%s\n' '[settings]' "api_key = ${WAKATIME_API}" >"$HOME/.wakatime.cfg"
}; fi

# signed commit
# https://github.com/gitpod-io/gitpod/issues/666#issuecomment-534347856
if [ ! -z $GNUGPG ]; then
    cd ~
    rm -rf .gnupg
    echo $GNUGPG | base64 -d | tar --no-same-owner -xzvf -
fi

if [ ! -z $GPG_KEY ]; then
    git config --global user.signingkey $GPG_KEY
fi

if [ -r ~/.bash_profile ]; then
    echo 'export GPG_TTY=$(tty)' >>~/.bash_profile
else
    echo 'export GPG_TTY=$(tty)' >>~/.profile
fi

##### TMUX #####

# Install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install tmux plugins
git clone https://github.com/wfxr/tmux-power ~/.tmux/plugins/tmux-power
git clone https://github.com/wfxr/tmux-net-speed ~/.tmux/plugins/tmux-net-speed
