#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_runatboot.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt
fmach_salir_si_no_instalado  ins_sys_buckets.txt


sudo  cp   /home/"$USER"/machina/unit/runatboot@.service   /etc/systemd/system/

sudo  systemctl daemon-reload
sudo  systemctl enable runatboot@"$USER".service
# NO le doy start
# sudo  systemctl start  runatboot@"$USER".service

# systemctl status runatboot

fmach_bitacora   "runatboot"
fmach_registrar_instalacion $logito