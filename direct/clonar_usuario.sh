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

wget https://github.com/"$estudiante_github_usuario" -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: no existe el usuario $estudiante_github_usuario  en GitHub"
  exit 1
fi


wget https://github.com/"$estudiante_github_usuario"/"$vcur_github_catedra_repo" -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: no existe el repo $estudiante_github_usuario/$vcur_github_catedra_repo  en GitHub"
  exit 1
fi



rm -rf "$vcur_repo_estudiante_destino"/"$vcur_github_catedra_repo"

cd  "$vcur_repo_estudiante_destino"

git clone https://"$estudiante_github_usuario":"$estudiante_github_token"@github.com/"$estudiante_github_usuario"/"$vcur_github_catedra_repo".git
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: no pude clonar  $estudiante_github_usuario / $vcur_github_catedra_repo"
  exit 1
fi

if [ ! -d  "$vcur_repo_estudiante_destino"/"$vcur_github_catedra_repo" ]; then
  echo "No existe la carpeta del repo $vcur_github_catedra_repo"
  exit 1
fi

# ingreso a la carpeta del repo
cd  "$vcur_repo_estudiante_destino"/"$vcur_github_catedra_repo"
git config  user.email "$estudiante_github_email"
git config  user.name "$estudiante_github_nombre"


git rev-parse  --veryfy origin/develop
if [ $? -eq 0 ]; then
  git rev-parse  --veryfy develop
  if [ ! $? -eq 0 ]; then
    git checkout -b develop
    if [ ! $? -eq 0 ]; then
      echo "Error Fatal: en clonar_usuario.sh no pude hacer : git checkout -b develop"
      exit 1
    fi

    git checkout -b origin/develop
    if [ ! $? -eq 0 ]; then
      echo "Error Fatal: en clonar_usuario.sh no pude hacer : git checkout -b origin/develop"
      exit 1
    fi
  fi
fi


git rev-parse  --veryfy main
if [ ! $? -eq 0 ]; then
  git checkout -b main origin/main
  if [ ! $? -eq 0 ]; then
    echo "Error Fatal: en clonar_usuario.sh no pude hacer : git checkout -b main origin/main"
    exit 1
  fi
fi


MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)
git remote  add  upstream  https://github.com/"$vcur_github_catedra_user"/"$vcur_github_catedra_repo"
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: no pude add upstream  $estudiante_github_usuario / $vcur_github_catedra_repo"
  exit 1
fi

git checkout -b catedra
git fetch upstream
git merge --no-ff  --allow-unrelated-histories  upstream/catedra  -m "sync upstream/catedra to catedra"

git commit --allow-empty  -m "catedra empty"
git pull --rebase  origin catedra
git push  origin  catedra
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: en clonar_usuario.sh no pude hacer : git push  origin  catedra"
  exit 1
fi

git checkout catedra
git fetch upstream
git merge --no-ff  --allow-unrelated-histories  upstream/main  -m "sync upstream/main to catedra"
git push  origin  catedra

git checkout main
git merge  -X theirs  catedra   -m "catedra manda"
git push --set-upstream origin  main

# activo el branch
git checkout main
git branch   "$MIHOST"
git checkout "$MIHOST"
git push origin "$MIHOST"


date >> "$vmach_bindir"/clonar_usuario.txt

exit 0