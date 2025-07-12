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

alias kns=kubens
alias kctx=kubectx
# Specific to my desktop, Malaz
alias prepcam="sudo modprobe v4l2loopback exclusive_caps=1 && sudo v4l2loopback-ctl add video3 && pkill gphoto"
alias dslrcam="gphoto2 --stdout autofocusdrive=1 --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video3"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source <(kubectl completion bash)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH=$PATH:$HOME/.dotfiles/go/bin
export PATH=$PATH:$HOME/.local/bin
export KUBECTX_IGNORE_FZF=1

pid=$(~/.dotfiles/dotUpdate.sh > /tmp/dotfiles.log 2>&1 &)
