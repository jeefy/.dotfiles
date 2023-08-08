#!/usr/bin/env bash

if [ ! -e /tmp/dotfiles ]; then
    echo "Fresh boot, doing some house cleaning";
    cd ~/.dotfiles || exit
    git fetch
    if [[ $(git diff main origin/main | wc -l) -ne 0 ]]; then
        echo "Updating dotfiles";
        git pull origin main
        echo "Done updating dotfiles";
        echo "Installing dotfiles/apps";
        sudo ./install -p dotbot-flatpak/flatpak.py
        echo "Done installing dotfiles/apps";
        echo "Final updates";
        just update
        just assemble
        echo "Complete. Bluefin is ready to go!";
    fi
    cd ~ || exit
    touch /tmp/dotfiles
fi