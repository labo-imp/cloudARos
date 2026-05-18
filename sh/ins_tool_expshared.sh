#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_tool_expshared.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


export smb_shared=expshared-austral

envsubst < /home/"$USER"/machina/sh/shareddirs.sh   >   "$vmach_bindir"/shareddirs.sh
chmod u+x  "$vmach_bindir"/shareddirs.sh

envsubst < /home/"$USER"/machina/cfg/expshared_cred.txt   >   "$vmach_bindir"/expshared_cred.txt

sudo  cp /home/"$USER"/machina/unit/shareddirs@.service  /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable shareddirs@"$USER".service
sudo  systemctl start  shareddirs@"$USER".service
# sudo systemctl status  shareddirs


fmach_bitacora   "tool_expshared"
fmach_registrar_instalacion $logito