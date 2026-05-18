#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

# multiples verificaciones
if [ ! -f /home/"$USER"/tmp/estudiante_secretos.sh ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/tmp/estudiante_secretos.sh"
    exit 1
fi


# conversion a newline de Linux
rm -f /home/"$USER"/tmp/estudiante_secretos.bak
mv /home/"$USER"/tmp/estudiante_secretos.sh  /home/"$USER"/tmp/estudiante_secretos.bak
perl -pe 's/\r\n|\r/\n/g'  /home/"$USER"/tmp/estudiante_secretos.bak  > /home/"$USER"/tmp/estudiante_secretos.sh
rm -f /home/"$USER"/tmp/estudiante_secretos.bak



# verificacion de los parametros de estudiante_secretos.sh
if ! grep -q estudiante_zulip_email /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_zulip_email"
    exit 1
fi

if ! grep -q estudiante_github_usuario /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_usuario"
    exit 1
fi

if ! grep -q estudiante_github_token /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_token"
    exit 1
fi

if ! grep -q estudiante_github_email /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_email"
    exit 1
fi

if ! grep -q estudiante_github_nombre /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_nombre"
    exit 1
fi


if  ! grep -q estudiante_github_token='"'ghp_   /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_token debe comenzar con ghp_"
    exit 1
fi


if  ! grep -E -o -q "\bestudiante_github_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_email debe tener forma de email"
    exit 1
fi

if  ! grep -E -o -q "\bestudiante_zulip_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_email debe tener forma de email"
    exit 1
fi


if  ! grep -q @   /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_token debe tener un arroba"
    exit 1
fi


if  grep -q “ /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q ” /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q "'" /home/"$USER"/tmp/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene comillas simples, y solo debe tener dobles"
    exit 1
fi



# Verificaciones en pagina GitHub, SIN clonar nada aun
cp  /home/"$USER"/tmp/estudiante_secretos.sh   "$vmach_bindir"/
chmod u+x  "$vmach_bindir"/estudiante_secretos.sh

# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  "$vmach_bindir"/estudiante_secretos.sh

rm -rf  /home/"$USER"/tmp2
mkdir -p /home/"$USER"/tmp2

wget https://github.com/"$estudiante_github_usuario" -O  /home/"$USER"/tmp2/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp2
  echo "Error Fatal: no existe el usuario $estudiante_github_usuario  en GitHub"
  exit 1
fi


wget https://github.com/"$estudiante_github_usuario"/"$vcur_github_catedra_repo" -O  /home/"$USER"/tmp2/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp2
  echo "Error Fatal: no existe el repo $estudiante_github_usuario/$vcur_github_catedra_repo  en GitHub"
  exit 1
fi


response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $estudiante_github_token" "https://api.github.com")
http_code=$(tail -n1 <<< "$response")
if [ ! "$http_code" -eq "200" ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: el estudiante_token_github NO es reconocido por www.github.com"
  exit 1
fi


# Pruebas del repositorio con CLONACION

rm -rf  /home/"$USER"/tmp2
mkdir -p /home/"$USER"/tmp2

cd  /home/"$USER"/tmp2 || exit 1

source  "$vmach_bindir"/estudiante_secretos.sh

git clone https://"$estudiante_github_usuario":"$estudiante_github_token"@github.com/"$estudiante_github_usuario"/"$vcur_github_catedra_repo".git
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: no pude clonar  $estudiante_github_usuario / $vcur_github_catedra_repo"
  exit 1
fi

if [ ! -d  /home/"$USER"/tmp2/"$vcur_github_catedra_repo" ]; then
  echo "Error Fatal: No existe la carpeta del repo $vcur_github_catedra_repo"
  exit 1
fi

# ingreso a la carpeta del repo
cd  /home/"$USER"/tmp2/"$vcur_github_catedra_repo"  || exit 1
git config  user.email "$estudiante_github_email"
git config  user.name "$estudiante_github_nombre"


git rev-parse  --veryfy -- origin/develop
if [ $? -eq 0 ]; then
  git rev-parse  --veryfy -- develop
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


git rev-parse  --veryfy -- main
if [ ! $? -eq 0 ]; then
  git checkout -b main origin/main
  if [ ! $? -eq 0 ]; then
    echo "Error Fatal: en clonar_usuario.sh no pude hacer : git checkout -b main origin/main"
    exit 1
  fi
fi


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



exit 0