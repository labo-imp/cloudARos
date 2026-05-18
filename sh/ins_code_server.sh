#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_code_server.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


curl -fsSL https://code-server.dev/install.sh | sh
sudo systemctl enable --now code-server"@$USER"


fmach_registrar_instalacion $logito