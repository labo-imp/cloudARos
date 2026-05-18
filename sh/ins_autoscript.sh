#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_autoscript.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_buckets.txt


sudo  cp   /home/"$USER"/machina/unit/autoscript@.service   /etc/systemd/system/

sudo  systemctl daemon-reload
sudo  systemctl enable autoscript@"$USER".service
sudo  systemctl start  autoscript@"$USER".service

# systemctl status autoscript

fmach_bitacora   "autoscript"
fmach_registrar_instalacion $logito