#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


logito="ins_common.txt"
fmach_salir_si_ya_instalado $logito


mkdir -p "$vmach_bindir"
mkdir -p "$vmach_logdir"

# multiples verificaciones
rm -rf  /home/"$USER"/tmp
mkdir -p /home/"$USER"/tmp

wget https://github.com/$vcur_github_catedra_user -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm  -f  /home/"$USER"/tmp/*
  echo "Error Fatal: no existe el usuario $vcur_github_catedra_user  en GitHub"
  exit 1
fi


wget https://github.com/$vcur_github_catedra_user/$vcur_github_catedra_repo  -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm  -f  /home/"$USER"/tmp/*
  echo "Error Fatal: no existe el repo $vcur_github_catedra_user/$vcur_github_catedra_repo  en GitHub"
  exit 1
fi


wget $vcur_webfiles/existe.txt  -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm  -f  /home/"$USER"/tmp/*
  echo "Error Fatal: no existe el archivo $vcur_webfiles/existe.txt"
  exit 1
fi


rm -rf  /home/"$USER"/tmp

fmach_registrar_instalacion $logito