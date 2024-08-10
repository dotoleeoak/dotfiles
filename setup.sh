#!/usr/bin/env bash
set -x

BASEDIR=$(dirname $0)
ln -sf ~/.jaemin $BASEDIR

# Add entry script
grep -q "~/.jaemin/myrc.sh" ~/.bashrc || echo "source ~/.jaemin/myrc.sh" >> ~/.bashrc

# TODO: install & setup nvim

ln -sf ~/.config/nvim $BASEDIR/nvim

# TODO: install fzf
# TODO: install & setup tmux
# TODO: install lazygit

# Load Wakatime API key
if [ ! -z WAKATIME_API ]; then {
    printf '%s\n' '[settings]' "api_key = ${WAKATIME_API}" > "$HOME/.wakatime.cfg";
} fi

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
    echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
else
    echo 'export GPG_TTY=$(tty)' >> ~/.profile
fi

