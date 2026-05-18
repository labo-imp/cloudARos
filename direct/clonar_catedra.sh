#!/bin/bash
# fecha revision   2026-05-18  12:02


# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh
# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  /home/"$USER"/buckets/b1/estudiante_secretos.sh



rm -rf  /home/"$USER"/tmp
mkdir -p /home/"$USER"/tmp


mkdir -p  /home/"$USER"/backup/
mkdir -p  /home/"$USER"/buckets/b1/backup/
mkdir -p  /home/"$USER"/buckets/b1/backup/catedra

rm -rf /home/"$USER"/backup/catedra


# verificacion existencia usuario GitHub de la catedra
wget https://github.com/"$vcur_github_catedra_user" -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: no existe el usuario $vcur_github_catedra_user  en GitHub"
  exit 1
fi

# verificacion existencia usuario GitHub y repo de la catedra
wget https://github.com/"$vcur_github_catedra_user"/"$vcur_github_catedra_repo" -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: no existe el repo $vcur_github_catedra_user/$vcur_github_catedra_repo  en GitHub"
  exit 1
fi


cd /home/"$USER"/backup/  || exit 1
git  clone https://github.com/"$vcur_github_catedra_user"/"$vcur_github_catedra_repo"   catedra
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: no pude clonar https://github.com/$vcur_github_catedra_user/$vcur_github_catedra_repo"
  exit 1
fi

cd /home/"$USER"/backup/catedra || exit 1
git checkout main

# sincronizo con la copia del bucket
mkdir -p /home/"$USER"/buckets/b1/backup/
mkdir -p /home/"$USER"/buckets/b1/backup/catedra
rsync -a /home/"$USER"/backup/catedra/   /home/"$USER"/buckets/b1/backup/catedra/  --delete-after

date >> "$vmach_bindir"/clonar_catedra.txt

