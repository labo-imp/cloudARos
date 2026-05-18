#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh


rm -rf  /home/"$USER"/tmp/
mkdir -p /home/"$USER"/tmp/
wget https://github.com/"$vmach_github_user"/"$vmach_github_repo" -O  /home/"$USER"/tmp/caca
if [ ! $? -eq 0 ]; then
  rm -rf  /home/"$USER"/tmp
  echo "No existe el repo $vmach_github_user/$vmach_github_repo  en GitHub"
  exit 0
fi


# clono el repo de instalacion
rm -rf /home/"$USER"/machina2
cd /home/"$USER"  || exit 1
git clone  https://github.com/"$vmach_github_user"/"$vmach_github_repo".git   machina2
if [ ! $? -eq 0 ]; then
  echo "No pude clonar $vmach_github_user/$vmach_github_repo"
fi


if [ -d  /home/"$USER"/machina2 ]; then
  rm -rf /home/"$USER"/machina
  cd /home/"$USER"  || exit 1
  mv machina2  machina
fi


# permisos de ejecucion
chmod u+x  /home/"$USER"/machina/curso/*.sh
chmod u+x  /home/"$USER"/machina/sh/*.sh
chmod u+x  /home/"$USER"/machina/jl/*.jl
chmod u+x  /home/"$USER"/machina/direct/*.sh

# personalizacion del curso
if [ ! -e /home/"$USER"/.curso ]; then
  gcloud secrets describe ds-curso
  if [ $? -eq 0 ]; then
    cursoarch=$(/usr/bin/gcloud secrets versions access latest --secret="ds-curso")
    if [  -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
      echo  "$cursoarch"  >  /home/"$USER"/.curso
    fi
  fi
fi


if [ -e /home/"$USER"/.curso ]; then
  cursoarch=$(cat /home/"$USER"/.curso)
  if [  -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
    cp  /home/"$USER"/machina/curso/"$cursoarch"  /home/"$USER"/machina/curso/common_curso.sh
  fi
fi


# este es nuevo y esta recien clonado
source  /home/"$USER"/machina/direct/services_recrear2.sh

date >> "$vmach_bindir"/services_recrear.txt
