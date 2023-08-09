update-dotfiles:
  cd ~/.dotfiles
  if [ $(git status --porcelain=v1 2>/dev/null | wc -l) -gt 0 ]; then \
    git add . && \
    git commit -m "shutdown update" && \
    git push; \
  fi

shutdown: update-dotfiles update assemble
  poweroff