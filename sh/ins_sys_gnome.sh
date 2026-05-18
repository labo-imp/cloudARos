#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_gnome.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# primera etapa, se instalan unos 1050 paquetes con el gnome
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade
#sudo  DEBIAN_FRONTEND=noninteractive  apt-get  install  --yes  slim
sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes  ubuntu-gnome-desktop

sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade

#sudo  DEBIAN_FRONTEND=noninteractive  apt-get  install  --yes  kde-plasma-desktop 

sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes \
  gnome-tweaks  language-pack-gnome-en  language-pack-gnome-es 


# para Remote Desktop
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade
sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes \
  xrdp  gnome-session  gnome-terminal  dbus-x11


cat >  /home/"$USER"/.xsession  <<FILE
gnome-session
export GDK_BACKEND=x11
export XDG_SESSION_TYPE=x11
FILE
chmod u+x /home/"$USER"/.xsession


sudo adduser "$USER" ssl-cert


cat >  /home/"$USER"/tmp/custom.conf  <<FILE
[daemon]
WaylandEnable=false

[security]

[debug]

FILE

sudo cp /home/"$USER"/tmp/custom.conf   /etc/gdm3/custom.conf

sudo systemctl restart xrdp
sudo systemctl restart gdm3

# instalo xrdp para acceder desde Windows por Remote Desktop
#sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes  xrdp


# disable multiple warnings
sudo  sed -i 's/<allow_inactive>no</<allow_inactive>yes</' /usr/share/polkit-1/actions/org.freedesktop.color.policy
sudo  sed -i 's/<allow_any>.*</<allow_any>yes</' /usr/share/polkit-1/actions/org.freedesktop.color.policy
sudo  sed -i 's/Prompt=.*/Prompt=never/' /etc/update-manager/release-upgrades

# para que no salga ventana de warning por culpa de bluetooth
sudo  systemctl  stop     bluetooth
sudo  systemctl  disable  bluetooth
sudo  DEBIAN_FRONTEND=noninteractive  apt-get remove --yes  bluez

sudo  systemctl disable --now systemd-oomd.socket
sudo  systemctl disable --now systemd-oomd
# sudo  systemctl status systemd-oomd

# sudo systemctl status systemd-networkd-wait-online.service
sudo systemctl disable systemd-networkd-wait-online.service
# sudo systemctl status systemd-networkd-wait-online.service

# quito imagen fondo de pantalla, dejo color BLACK  solido
dbus-run-session  gsettings set org.gnome.desktop.background picture-uri none
dbus-run-session  gsettings set org.gnome.desktop.background primary-color '#000000'
dbus-run-session  gsettings set org.gnome.desktop.background color-shading-type 'solid'

# cambio los timeouts de idle
dbus-run-session  gsettings set org.gnome.desktop.screensaver lock-enabled true
dbus-run-session  gsettings set org.gnome.desktop.screensaver lock-delay 1200
dbus-run-session  gsettings set org.gnome.desktop.session idle-delay 600

fmach_bitacora   "sys_gnome"
fmach_registrar_instalacion $logito