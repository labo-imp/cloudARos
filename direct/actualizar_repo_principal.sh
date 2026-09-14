#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

cd  "$vcur_repo_estudiante_destino"/"$vcur_github_catedra_repo"  || exit 1

# upstream a  catedra
git checkout catedra
git pull origin catedra
git fetch upstream
git merge -X theirs  upstream/main  -m "sync upstream/main to catedra"


# catedra a main
git checkout main
git pull origin main
git merge  -X theirs  catedra   -m "catedra domina a main"

# creo la branch en caso que no exista, a partir de main
git branch    "$MIHOST"

# catedra pisa a HOST
git checkout  "$MIHOST"
git merge  -X theirs  catedra   -m "catedra domina  a HOST"
git merge  -X ours  main   -m "HOST domina  a main"
git checkout  "$MIHOST"

date >> "$vmach_bindir"/actualizar_repo_principal.txt