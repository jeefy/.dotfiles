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
        echo "Done installing dotfiles/apps";
        flatpak install -u "$(cat ~/.dotfiles/Flatfile)"
        brew bundle --file=~/.dotfiles/Brewfile
        cat ~/.dotfiles/CodeExtensionsfile | xargs -L 1 echo code --install-extension
    fi

    /usr/bin/topgrade --config /usr/share/ublue-os/topgrade.toml --disable=oh-my-zsh

    brew bundle dump --force --file=~/.dotfiles/Brewfile
    flatpak list --app -u --columns=application > ~/.dotfiles/Flatfile
    code --list-extensions > ~/.dotfiles/CodeExtensionsfile
    git add .
    git commit -m "auto-update"
    git push origin main

    echo "Complete. Bluefin is ready to go!";

    cd ~ || exit
    touch /tmp/dotfiles
fi
