#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_services_recrear.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_architecture.txt


# reemplazo dentro del archivo unit
#sudo  cp   /home/"$USER"/machina/unit/services_recrear@.service   "$vmach_bindir"
#sed -i  "s|carpeta|$vmach_bindir|g"  "$vmach_bindir"/services_recrear@.service

sudo  cp   /home/"$USER"/machina/unit/services_recrear@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable  services_recrear@"$USER".service
# No le hago el start


fmach_bitacora   "sys_services_recrear"
fmach_registrar_instalacion $logito