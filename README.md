```
git clone git@github.com:jeefy/.dotfiles.git
sudo usermod -aG docker $USER
sudo bootc switch --enforce-container-sigpolicy ghcr.io/ublue-os/bluefin-dx:stable
cd .dotfiles && ./install
```

For Razer support
```
curl https://download.opensuse.org/repositories/hardware:/razer/Fedora_$(rpm -E %fedora)/hardware:razer.repo -O /etc/yum.repos.d/razer.repo
rpm-ostree install openrazer-meta
```