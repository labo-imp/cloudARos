#!/bin/bash

# corre durante instalacion
mkdir  -p  /home/"$USER"/backup
mkdir  -p  /home/"$USER"/buckets/b1/backup
mkdir  -p  /home/"$USER"/buckets/b1/backup/catedra
mkdir  -p  /home/"$USER"/buckets/b1/backup/"$vcur_github_catedra_repo"

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

# repo oficial de la catedra "de cero"
# corre durante instalacion

rm -rf /home/"$USER"/backup/catedra
cd   /home/"$USER"/backup/ || exit 1
git  clone https://github.com/"$vcur_github_catedra_user"/"$vcur_github_catedra_repo"   catedra

cd  /home/"$USER"/backup/catedra  || exit 1
git checkout main


# sincronizo con la copia del bucket
rsync -a /home/"$USER"/backup/catedra  /home/"$USER"/buckets/b1/backup/catedra/  --delete-after

date >> "$vmach_bindir"/creacion_repos_auxiliares.txt
