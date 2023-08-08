shutdown:
  just update-dotfiles
  poweroff

update-dotfiles:
  cd ~/.dotfiles && \
  git add . && \
  git commit -m "shutdown update" && \
  git push