#!/bin/bash
# fecha revision   2026-05-18  12:02

# ese script corre en Google Cloud Shell
# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

# abort on any subprocess error
set -eo pipefail

# instalo acceso al storage bucket
/home/"$USER"/machina/sh/ins_sys_buckets_shell.sh


# verifico el repo de la catedra
rm -f "$vmach_logdir"/ins_common.txt
/home/"$USER"/machina/sh/ins_common.sh


# verifico secretos
/home/"$USER"/machina/sh/ins_estudiante_secretos.sh

# verifico creacion de repo en shell
/home/"$USER"/machina/sh/ins_crear_repos.sh

# verifico submit a Kaggle
/home/"$USER"/machina/sh/ins_kaggle_shell.sh

printf "\n\n\n"
printf "Ha finalizado correctamente la verificacion de archivos. Continue con La Gran Instalacion.\n\n"
