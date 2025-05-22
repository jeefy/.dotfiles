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
        brew bundle --file=~/.dotfiles/Brewfile
        flatpak install -y -u "$(cat ~/.dotfiles/Flatfile)"
        cat ~/.dotfiles/CodeExtensionsfile | xargs -L 1 echo code --install-extension
        echo "Done installing dotfiles/apps";
    fi

    topgrade --disable=shell --yes

    brew bundle dump --force --file=~/.dotfiles/Brewfile
    flatpak list --app -u --columns=application > ~/.dotfiles/Flatfile
    code --list-extensions > ~/.dotfiles/CodeExtensionsfile
    dconf dump /org/gnome/Ptyxis/ > ~/.dotfiles/dconf/ptyxis.conf
    gnome-extensions list --user --active --enabled > ~/.dotfiles/gnome-extensions-list
    git add .
    git commit -m "auto-update"
    git push origin main

    echo "Complete. Bluefin is ready to go!";

    cd ~ || exit
    touch /tmp/dotfiles
fi
