#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_lib_xgboost.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_rworld_first.txt
fmach_salir_si_no_instalado  ins_tool_semaforo.txt


"$vmach_bindir"/semaforo open /sem_xgboost  0

cd /home/"$USER"  || exit 1
rm -rf  xgboost
git clone --recursive  https://github.com/dmlc/xgboost
cd xgboost  || exit 1
git submodule init
git submodule update
cd R-package   || exit 1
R CMD INSTALL .
cd /home/"$USER"  || exit 1
rm -rf  xgboost


"$vmach_bindir"/semaforo  post /sem_xgboost

fmach_bitacora   "lang_lib_xgboost"
fmach_registrar_instalacion $logito