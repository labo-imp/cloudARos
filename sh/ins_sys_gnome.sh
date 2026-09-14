#!/bin/bash
# fecha revision   2026-09-14  17:47

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_gnome.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# primera etapa, se instalan unos 1050 paquetes con el gnome
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade
#sudo  DEBIAN_FRONTEND=noninteractive  apt-get  install  --yes  slim
sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes  ubuntu-gnome-desktop   gnome-remote-desktop

sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade

#sudo  DEBIAN_FRONTEND=noninteractive  apt-get  install  --yes  kde-plasma-desktop 

sudo  DEBIAN_FRONTEND=noninteractive  nala  install  --assume-yes \
  gnome-tweaks  language-pack-gnome-en  language-pack-gnome-es 


# para Remote Desktop -----------------------------------------------
# This is the *device* credential shown at the RDP login prompt,
# NOT your Ubuntu account password.
RDP_DEVICE_USER="ds"

CLAVE=$(/usr/bin/gcloud secrets versions access latest --secret="ds-password")
RDP_PASS="$CLAVE"

SYSTEM_CERT_DIR="/var/lib/gnome-remote-desktop"
CERT_FILE="rdp-tls.crt"
KEY_FILE="rdp-tls.key"

echo "[1/5] Creating certificate directory..."
sudo mkdir -p "$SYSTEM_CERT_DIR"

echo "[2/5] Generating self-signed TLS certificate (PEM format)..."
sudo openssl req -newkey rsa:2048 -nodes \
    -keyout "$SYSTEM_CERT_DIR/$KEY_FILE" \
    -x509 -days 3650 \
    -out  "$SYSTEM_CERT_DIR/$CERT_FILE" \
    -subj "/CN=$(hostname)"

sudo chown gnome-remote-desktop:gnome-remote-desktop \
    "$SYSTEM_CERT_DIR/$KEY_FILE" \
    "$SYSTEM_CERT_DIR/$CERT_FILE"
sudo chmod 600 "$SYSTEM_CERT_DIR/$KEY_FILE"
sudo chmod 644 "$SYSTEM_CERT_DIR/$CERT_FILE"

echo "[3/5] Enabling and starting gnome-remote-desktop system service..."
sudo systemctl enable --now gnome-remote-desktop.service

echo "[4/5] Configuring system RDP (headless/Remote Login mode)..."
sudo grdctl --system rdp set-tls-key  "$SYSTEM_CERT_DIR/$KEY_FILE"
sudo grdctl --system rdp set-tls-cert "$SYSTEM_CERT_DIR/$CERT_FILE"

CLAVE=$(/usr/bin/gcloud secrets versions access latest --secret="ds-password")
sudo grdctl --system rdp set-credentials ds "$CLAVE"

sudo grdctl --system rdp enable

sudo grdctl --system status --show-credentials

# Fin Remote Desktop ------------------------------------------------


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