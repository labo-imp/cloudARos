#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_crear_repos.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_buckets.txt

source  /home/"$USER"/buckets/b1/estudiante_secretos.sh

/home/"$USER"/machina/direct/clonar_usuario.sh
if [ ! $? -eq 0 ]; then
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "Ha fallado clonar_usuario.sh, saliendo de la instalacion"
  exit 1
fi

/home/"$USER"/machina/sh/verificar_repo_estudiante.sh
if [ ! $? -eq 0 ]; then
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "$fecha" > "$vmach_logdir"/ins_crear_repo_ERROR.txt
  exit 1
fi

# grabo
fecha=$(date +"%Y%m%d %H%M%S")
echo "$fecha" > "$vmach_logdir"/ins_crear_repo_usuario.txt


#--------------------------------------

# repo oficial de la catedra "de cero"
# corre durante instalacion

/home/"$USER"/machina/direct/clonar_catedra.sh
if [ ! $? -eq 0 ]; then
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "$fecha" > "$vmach_logdir"/clonar_catedra_ERROR.txt
  exit 1
fi


# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

fmach_bitacora "crear_repos"
fmach_registrar_instalacion $logito