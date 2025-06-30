# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
### bling.sh source start
test -f /usr/share/ublue-os/bling/bling.sh && source /usr/share/ublue-os/bling/bling.sh
### bling.sh source end
export KUBECTX_IGNORE_FZF=1

alias kns=kubens
alias kctx=kubectx
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH=$PATH:$HOME/.dotfiles/go/bin
export PATH=$PATH:$HOME/.local/bin

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source <(kubectl completion bash)

pid=$(~/.dotfiles/dotUpdate.sh > /tmp/dotfiles.log 2>&1 &)
