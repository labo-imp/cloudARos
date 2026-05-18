#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
logito="ins_plat_zulip.txt"
fmach_salir_si_no_instalado  ins_sys_system.txt


source  /home/"$USER"/buckets/b1/estudiante_secretos.sh

# cambio in-situ de estudiante_zulip_email
cp /home/"$USER"/machina/direct/zulip_enviar.sh  "$vmach_bindir"/
sed -i  's/email/'$estudiante_zulip_email'/g'  "$vmach_bindir"/zulip_enviar.sh


fmach_bitacora   "plat_zulip"
fmach_registrar_instalacion $logito