update-dotfiles:
  cd ~/.dotfiles && \
  git add . && \
  git commit -m "shutdown update" && \
  git push

shutdown: update-dotfiles update assemble
  poweroff