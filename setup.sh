#!/bin/sh
set -x

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

if [ -r ~/.bash_profile]; then
    echo 'export GPG_TTY=$(tty)' >> ~/.bash_profile
else
    echo 'export GPG_TTY=$(tty)' >> ~/.profile
fi
