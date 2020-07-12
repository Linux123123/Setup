#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "* This script must be executed with root privileges (sudo)." 1>&2
  exit 1
fi

apt-get update -y
apt-get upgrade -y
apt-get full-upgrade -y
apt-get install curl git wget nano bash pastebinit tmux -y
apt-get autoremove -y
apt-get clean -y

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

echo "* Retrieving release information.."
VERSION="$(get_latest_release "Linux1231233/setup")"

echo "* Latest version is $VERSION"

curl -o /opt/update.sh https://raw.githubusercontent.com/Linux1231233/setup/master/scripts/update.sh

echo '0 0 * * * root sudo bash /opt/update.sh >> /var/log/daily-update.log 2>&1' | sudo tee -a /etc/crontab
