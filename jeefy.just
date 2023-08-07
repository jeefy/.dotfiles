shutdown:
  cd ~/.dotfiles && \
  git add . && \
  git commit -m "shutdown update" && \
  git push && \
  poweroff
