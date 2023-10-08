FROM ghcr.io/ublue-os/ubuntu-toolbox:latest

RUN useradd -m -s /bin/bash linuxbrew && \
    echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers && \
    apt-get update && \
    apt-get install -y build-essential

USER linuxbrew

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)" && \
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/linuxbrew/.profile && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

RUN /home/linuxbrew/.linuxbrew/bin/brew install \
    kubectl kubectx

USER root
