#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_autoexec.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_services_recrear.txt


sudo  cp  /home/"$USER"/machina/unit/autoexec@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable autoexec@"$USER".service

fmach_bitacora   "autoexec"
fmach_registrar_instalacion $logito