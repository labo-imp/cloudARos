#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_lib_lentosR.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_rworld_first.txt
fmach_salir_si_no_instalado  ins_tool_semaforo.txt


# grabacion  inicial
fecha=$(date +"%Y%m%d %H%M%S")
echo "$fecha" > "$vmach_logdir"/ins_lentosR_iniciado.txt


# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

"$vmach_bindir"/semaforo open /sem_lentosR  0

mkdir -p /home/"$USER"/.R
echo "MAKEFLAGS = -j4"  >> /home/"$USER"/.R/Makevars
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_lentos.r

"$vmach_bindir"/semaforo  post /sem_lentosR
"$vmach_bindir"/semaforo  post /sem_lentosR

fmach_bitacora   "lang_lib_lentosR"
fmach_registrar_instalacion $logito