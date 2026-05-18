#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_architecture.txt"
fmach_salir_si_ya_instalado $logito


# instalo Google Cloud SDK
# Documentacion  https://cloud.google.com/sdk/docs/install#deb

sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  DEBIAN_FRONTEND=noninteractive apt-get install --yes nala

sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes  apt-transport-https ca-certificates gnupg curl perl iputils-ping

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo DEBIAN_FRONTEND=noninteractive apt-get update && sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes  google-cloud-cli


# arquitectura
#sudo  DEBIAN_FRONTEND=noninteractive  apt-get update  && sudo dpkg --add-architecture  i386
sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes  software-properties-common  build-essential


fmach_bitacora   "sys_architecture"
fmach_registrar_instalacion $logito