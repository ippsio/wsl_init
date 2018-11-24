#!/bin/bash
umask 022
unsetopt BG_NICE

install() {
  echo "INSTALL '$1'."
  installed=$(dpkg -l $1; echo $?)
  if [ "${installed}" == "0" ]; then
    sudo apt-get install -y $1
  else
    echo "SKIP. ALREADY INSTALLED"
  fi
}

install git
install awk
install vim
install zsh
cp ./.zshrc.org ~/.zshrc
cp ./.zshenv.org ~/.zshenv
cp ./.zshenv.org ~/.zshenv
cp ./.profile ~/.profile

# zplug
mkdir -p ~/.zsh
curl \
  -sL --proto-redir -all,https \
  https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Please reopen terminal"
