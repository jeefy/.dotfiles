```
ujust devmode
sudo rpm-ostree install libudev-devel
git clone git@github.com:jeefy/.dotfiles.git
cd .dotfiles && ./install
```

For Razer support
```
curl https://download.opensuse.org/repositories/hardware:/razer/Fedora_$(rpm -E %fedora)/hardware:razer.repo -O /etc/yum.repos.d/razer.repo
rpm-ostree install openrazer-meta
```
