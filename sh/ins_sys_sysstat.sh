#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_sysstat.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt

sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get install sysstat -y 

if [ -e /etc/cron.d/sysstat ]; then
  sudo  sed -i  's/5-55\/10/1-59\/1/' /etc/cron.d/sysstat
fi

sudo  sed -i  's/ENABLED=\"false\"/ENABLED=\"true\"/'    /etc/default/sysstat
sudo  service sysstat restart
sudo  systemctl daemon-reload


fmach_bitacora   "sys_sysstat"
fmach_registrar_instalacion $logito