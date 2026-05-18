#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_buckets.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_architecture.txt


# instalo Google Cloud Fuse  para poder ver el bucket  Version:  3.9.0 | Released:2026-04-22
# Documentacion https://cloud.google.com/storage/docs/gcs-fuse?hl=en-419

gcsfusever="3.9.0"
gcsfusepack="gcsfuse_""$gcsfusever""_amd64.deb"
cd /home/"$USER" || exit 1
curl  -L -O "https://github.com/GoogleCloudPlatform/gcsfuse/releases/download/v$gcsfusever/$gcsfusepack"
sudo  DEBIAN_FRONTEND=noninteractive  dpkg --install "$gcsfusepack"
rm  -f  /home/"$USER"/"$gcsfusepack"


sudo mkdir -p  /mnt/
sudo mkdir -p  /mnt/gcsfuse/
sudo mkdir -p  /mnt/cache/
sudo mkdir -p  /mnt/alive/
sudo chown -R  "$USER":"$USER" /mnt/gcsfuse/
sudo chown -R  "$USER":"$USER" /mnt/alive/
sudo chown -R  "$USER":"$USER" /mnt/cache/

# Preparo para que puedan haber 9 buckets al mismo tiempo
mkdir  -p  /home/"$USER"/buckets
mkdir  -p  /home/"$USER"/buckets/b1
mkdir  -p  /home/"$USER"/buckets/b2
mkdir  -p  /home/"$USER"/buckets/b3
mkdir  -p  /home/"$USER"/buckets/b4
mkdir  -p  /home/"$USER"/buckets/b5
mkdir  -p  /home/"$USER"/buckets/b6
mkdir  -p  /home/"$USER"/buckets/b7
mkdir  -p  /home/"$USER"/buckets/b8
mkdir  -p  /home/"$USER"/buckets/b9


sudo ln -s /home/"$USER"/   /content
sudo chown -R  "$USER":"$USER" /content



sudo  cp   /home/"$USER"/machina/unit/buckets@.service   /etc/systemd/system/


sudo  systemctl daemon-reload
sudo  systemctl enable  buckets@"$USER".service
sudo  systemctl start  buckets@"$USER".service
#systemctl status buckets@"$USER".service


sleep 5

# finalizo
systemctl is-active --quiet buckets@"$USER".service
if [ ! $? -eq 0 ]; then
    echo "servicio buckets no esta funcionando"
    exit 1
fi


fmach_bitacora   "sys_buckets"
fmach_registrar_instalacion $logito