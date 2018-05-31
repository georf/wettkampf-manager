#!/bin/bash
set -e
INSTALL_APT=yes
INSTALL_PATH=wettkampf-manager
INSTALL_PATH_ARG="$1"

if [[ "$1" == "SKIP_INSTALL_APT" ]] ; then
  INSTALL_APT=no
  INSTALL_PATH_ARG="$2"
  echo 'Installieren von Paketen wird übersprungen'
fi

if [[ "$INSTALL_PATH_ARG" != "" ]] ; then
  INSTALL_PATH="$INSTALL_PATH_ARG"
  echo "Installiere zu Pfad: $INSTALL_PATH"
fi

if [[ "$INSTALL_APT" == "yes" ]] ; then
  if [ $(which sudo | wc -l) -lt 1 ] ; then
    echo 'sudo is not installed'
    exit 1
  fi

  sudo apt-get -y install nodejs curl git dirmngr bzip2 gawk g++ gcc make libc6-dev zlib1g-dev libyaml-dev \
    libsqlite3-dev sqlite3 autoconf libgmp-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config \
    libffi-dev libgmp-dev libreadline-dev libssl-dev
fi

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --autolibs=read-fail
echo 'source "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
source "$HOME/.rvm/scripts/rvm"

rvm install ruby-2.4.4
git clone -b release --recursive https://github.com/Feuerwehrsport/wettkampf-manager.git "$INSTALL_PATH"

cd "$INSTALL_PATH"
doc/scripts/install.sh

echo ''
echo 'Sie müssen diese Session/Shell neu starten, um alle Funktionen nutzen zu können.'
echo 'Folgende Funktionen stehen bereit:'
echo ''
echo ' rails server -e production -p 3000 -b 0.0.0.0 # Webserver'
echo ' rails console -e production # Konsole'
echo ' rails runner -e production "API::Runner.new" # Externes Gerät'
echo ' RAILS_ENV=production rake backup_data_recurring # Auto-Backup'
echo ''
