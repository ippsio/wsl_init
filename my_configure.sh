#!/bin/bash

cp ./.profile ~/.profile
source ~/.profile

umask 022
#unsetopt BG_NICE

install() {
  echo "INSTALL '$1'."
  installed=$(dpkg -l $1; echo $?)
  if [ "${installed}" != "0" ]; then
    sudo apt-get install -y $1
  else
    echo "SKIP. ALREADY INSTALLED"
  fi
}

install git
install awk
install vim
install zsh

# docker
install docker.io
sudo cgroupfs-mount
sudo usermod -aG docker $USER
sudo service docker start

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cp ./.zshrc.org ~/.zshrc
cp ./.zshenv.org ~/.zshenv
cp ./.zshenv.org ~/.zshenv

# zplug
mkdir -p ~/.zsh
curl \
  -sL --proto-redir -all,https \
  https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Please reopen terminal"
