#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_tool_semaforo.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


[ ! -e "/home/$USER/machina/c/semaforo.c" ] && exit 1
gcc /home/"$USER"/machina/c/semaforo.c  -lpthread -o  "$vmach_bindir"/semaforo
[ ! -e "$vmach_bindir/semaforo" ] && exit 1
chmod u+x  "$vmach_bindir"/semaforo


fmach_bitacora   "sys_semaforo"
fmach_registrar_instalacion $logito