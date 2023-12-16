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
    fi

    if [[ $(cat /etc/os-release | grep -c "Ubuntu") -ne 0 ]]; then
        echo "Ubuntu detected, installing Ubuntu specific packages";
        sudo apt update
        sudo apt install -y build-essential gcc
    fi
    
    echo "Updating brew";
    brew update
    brew upgrade

    echo "Complete. Bluefin is ready to go!";

    cd ~ || exit
    touch /tmp/dotfiles
fi

export DOCKER_HOST=unix:///run/user/1000/podman/podman.sock