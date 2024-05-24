```
just zsh
git clone git@github.com:jeefy/.dotfiles.git && \
cd .dotfiles && \
sudo ./install --plugin-dir dotbot-flatpak
```

flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user install la.ogri.strongbox