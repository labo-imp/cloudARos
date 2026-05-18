#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_tool_memcpu.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


rm -f "$vmach_bindir"/memcpu  "$vmach_bindir"/settimeout
gcc -Wall /home/"$USER"/machina/c/memcpu.cpp   -o "$vmach_bindir"/memcpu `pkg-config --libs gio-2.0 --cflags`
gcc  /home/"$USER"/machina/c/settimeout.cpp   -o "$vmach_bindir"/settimeout


cp /home/"$USER"/machina/direct/settimeout.sh  "$vmach_bindir"/


sudo  cp  /home/"$USER"/machina/unit/memcpu@.service   /etc/systemd/system/

sudo  systemctl daemon-reload
sudo  systemctl enable  memcpu@"$USER".service
# sudo  systemctl start  memcpu
# sudo  systemctl status  memcpu


fmach_bitacora   "tool_memcpu"
fmach_registrar_instalacion $logito