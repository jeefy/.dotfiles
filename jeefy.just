update-dotfiles:
  cd ~/.dotfiles
  if [ $(git status --porcelain=v1 2>/dev/null | wc -l) -gt 0 ]; then \
    git add . && \
    git commit -m "shutdown update" && \
    git push; \
  fi

shutdown: update-dotfiles update assemble
  poweroff

podmansh-dev:
  sudo mkdir -p /etc/containers/systemd/users/${UID}
  sudo cp ~/.dotfiles/podmansh.container /etc/containers/systemd/users/${UID}/podmansh.container
  sudo lchsh $USER "/usr/bin/podmansh -c zsh"
  systemctl --user start podman.socket
  loginctl enable-linger $(whoami)

  podman pull ghcr.io/ublue-os/ubuntu-toolbox:latest
  
  systemctl --user daemon-reload
  systemctl --user stop podmansh.service
  systemctl --user start podmansh.service
  
  @echo "Shell now switched to podmansh. Spawn a new terminal to get going!"
  @echo "By default, the shell will be Bash. To override it, create ~/.profile with your preferred shell"
  @echo "Note: That shell must exist in the toolbox!"
  @echo "To ensure a smooth experience within VSCode, please add the following to your settings.json:"
  @echo "---"
  @echo "\"terminal.integrated.profiles.linux\": {"
  @echo "  \"podmansh zsh\": {"
  @echo "     \"path\": \"podmansh\","
  @echo "     \"args\": [\"-c\", \"cd \${workspaceFolder}; exec zsh\"]"
  @echo "  }"
  @echo "}"
  @echo "---"
  @echo "Happy Podmansh'ing!"

podmansh-switch-dev IMAGE:
  sudo sed -i "/Image\=.*$/c Image\={{IMAGE}}" /etc/containers/systemd/users/${UID}/podmansh.container
  podman pull {{IMAGE}}
  podman rm -f podmansh
  systemctl --user daemon-reload
  systemctl --user start podmansh.service
  echo "Image now switched to {{IMAGE}}"
