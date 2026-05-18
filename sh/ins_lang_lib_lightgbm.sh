#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_lib_lightgbm.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_rworld_first.txt
fmach_salir_si_no_instalado  ins_tool_semaforo.txt


"$vmach_bindir"/semaforo open /sem_lightgbm  0

cd /home/"$USER"  || exit 1
rm -rf  LightGBM
git clone --recursive  https://github.com/Microsoft/LightGBM
cd LightGBM  || exit 1
Rscript ./build_r.R
cd /home/"$USER" || exit 1
rm -rf  LightGBM

fmach_bitacora   "R  lightgbm"

Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_3.r
fmach_bitacora   "R  packages 3"

"$vmach_bindir"/semaforo  post /sem_lightgbm

fmach_bitacora   "lang_lib_lightgbm"
fmach_registrar_instalacion $logito