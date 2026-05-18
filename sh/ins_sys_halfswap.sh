#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_halfswap.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


sudo  cp  /home/"$USER"/machina/unit/halfswap@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable halfswap@"$USER".service
# sudo  systemctl start  halfswap
# sudo systemctl status  shareddirs


fmach_bitacora   "sys_halfswap"
fmach_registrar_instalacion $logito