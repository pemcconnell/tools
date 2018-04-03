#!/bin/bash

# Repositories
sudo add-apt-repository -y ppa:nilarimogard/webupd8
sudo add-apt-repository -y ppa:gezakovacs/ppa
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update

# Required packages
sudo apt install -y \
    atom \
    alsa-tools steam \
    net-tools nmap jq fuse-exfat exfat-utils bluez-tools tilix ncdu unetbootin isyslinux-utils \
    budgie-desktop budgie-screenshot-applet budgie-haste-applet budgie-weather-applet \
    budgie-indicator-applet \
    lightdm nvidia-390 touchegg compizconfig-settings-manager gnome-tweak-tool \
    virtualbox libqt5opengl5 libqt5opengl5-gles libqt5printsupport5 libqt5x11extras5 libsdl1.2debian \
    klavaro \
    fakeroot icoutils innoextract \
    docker docker-compose \
    terraform graphviz packer ansible \
    openjdk-8-jdk-headless python-pip ipython ruby r-cran-littler \
    apt-transport-https ca-certificates curl software-properties-common \
    spotify-client \
    whois \
    ecryptfs-utils cryptsetup \
    network-manager-openvpn network-manager-openvpn-gnome haproxy

# Fix mouse pointer issue
sudo ubuntu-drivers autoinstall

# Fix audio jack cracking problem
sudo hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x67
sudo hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x3000
sudo hda-verb /dev/snd/hwC0D2 0x20 SET_COEF_INDEX 0x67
sudo hda-verb /dev/snd/hwC0D2 0x20 SET_PROC_COEF 0x3000

# Install GDrive
apt install -y python-pyinotify expect libyajl-dev libboost-test-dev binutils-dev libboost-program-options-dev libboost-filesystem-dev libcurl4-openssl-dev libgcrypt11-dev libappindicator1
wget http://ftp.uk.debian.org/debian/pool/main/j/json-c/libjson-c2_0.11-4_amd64.deb
wget http://ftp.uk.debian.org/debian/pool/main/j/json-c/libjson0-dev_0.11-4_amd64.deb
wget http://ftp.uk.debian.org/debian/pool/main/j/json-c/libjson-c-dev_0.11-4_amd64.deb
wget http://ftp.uk.debian.org/debian/pool/main/j/json-c/libjson0_0.11-4_amd64.deb
wget https://launchpad.net/~thefanclub/+archive/ubuntu/grive-tools/+files/grive-tools_1.15_all.deb
sudo dpkg -i libjson-c2_0.11-4_amd64.deb
sudo dpkg -i libjson0_0.11-4_amd64.deb
sudo dpkg -i libjson-c-dev_0.11-4_amd64.deb
sudo dpkg -i libjson0-dev_0.11-4_amd64.deb
sudo dpkg -i grive-tools_1.15_all.deb

# encrypt home directory
# https://www.howtogeek.com/116032/how-to-encrypt-your-home-folder-after-installing-ubuntu/

# Install PyCharm
sudo snap install pycharm-community --classic

# Disable sleep on lid close
sudo sed -i '' "s/#HandleLidSwitch=suspend/HandleLidSwitch=ignore/" /etc/systemd/logind.conf
sudo systemctl restart systemd-logind

# Install TomTom Connect
wget http://launchpadlibrarian.net/215074266/libgstreamer0.10-0_0.10.36-1.5ubuntu1_amd64.deb
wget http://launchpadlibrarian.net/185267586/gstreamer0.10-plugins-base_0.10.36-2_amd64.deb
wget http://launchpadlibrarian.net/185267581/libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
wget https://sports.tomtom-static.com/downloads/desktop/mysportsconnect/latest/tomtomsportsconnect.x86_64.deb
sudo dpkg -i libgstreamer0.10-0_0.10.36-1.5ubuntu1_amd64.deb
sudo dpkg -i libgstreamer-plugins-base0.10-0_0.10.36-2_amd64.deb
sudo dpkg -i gstreamer0.10-plugins-base_0.10.36-2_amd64.deb
sudo dpkg -i tomtomsportsconnect.x86_64.deb

# Backup
wget https://updates.duplicati.com/beta/duplicati_2.0.3.3-1_all.deb
sudo dpkg -i duplicati_2.0.3.3-1_all.deb
sudo apt --fix-broken install

# Remarkable Markdown editor
wget https://remarkableapp.github.io/files/remarkable_1.87_all.deb
sudo dpkg -i remarkable_1.87_all.deb
sudo apt --fix-broken install

# pip install some packages
pip install IPython
pip install py-rest-client
pip install awscli --upgrade --user

# configure haproxy
sudo bash -c "cat >> /etc/haproxy/haproxy.cfg" << EOL

backend bkp
    server bkp 127.0.0.1:8200

frontend lh
    bind *:80
    use_backend bkp if { hdr(Host) -i duplicati }
    use_backend bkp if { hdr(Host) -i bkp }
EOL

echo "127.0.0.1 duplicati bkp" | sudo tee -a /etc/hosts

# Install kubernetes
sudo snap install kubectl --classic

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-linux-amd64
chmod +x minikube
sudo mv minikube /usr/local/bin/

# Initialize minikube
minikube start
minikube stop

