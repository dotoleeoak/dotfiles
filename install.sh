#!/usr/bin/env bash

# TODO: check os (only support linux & mac)
# TODO: check sudo permission
# TODO: clone repo to specific directory
# TODO: set basedir to the repo directory
BASEDIR=$(realpath $(dirname $0))
echo "BASEDIR: $BASEDIR"

# Install homebrew (Mac only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install zsh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt install -y zsh
    chsh -s $(which zsh)
fi

# Add entry script
if ! grep -q "source $BASEDIR/setup.sh" $HOME/.zshrc; then
    echo "source $BASEDIR/setup.sh" >>$HOME/.zshrc
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install powerlevel10k
# TODO: auto-install with git submodule
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.p10k
exec zsh
p10k configure

# Install neovim
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm nvim-linux64.tar.gz
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install neovim
fi

if [ -d $HOME/.config/nvim ]; then
    if [ "$(readlink $HOME/.config/nvim)" != "$BASEDIR/nvim" ]; then
        echo "ERROR: $HOME/.config/nvim exists" >&2
        exit 1
    fi
else
    ln -sf "$BASEDIR/nvim" "$HOME/.config/nvim"
fi

# Install fzf
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ ! -d $HOME/.fzf ]; then
        # TODO: manage with git submodules
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    fi
    $HOME/.fzf/install
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install fzf
fi

# Install lazygit
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit lazygit.tar.gz
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install lazygit
fi

# Install tmux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt install -y tmux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install tmux
fi

if [ -d $HOME/.config/tmux ]; then
    if [ "$(readlink $HOME/.config/tmux)" != "$BASEDIR/tmux" ]; then
        echo "ERROR: $HOME/.config/nvim exists" >&2
        exit 1
    fi
else
    ln -sf "$BASEDIR/tmux" "$HOME/.config/tmux"
fi

# Install tpm
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
