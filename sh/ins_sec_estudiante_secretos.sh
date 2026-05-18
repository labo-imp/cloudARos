#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sec_estudiante_secretos.txt"
fmach_salir_si_no_instalado  ins_sys_buckets.txt


# multiples verificaciones

if [ ! -d "$vmach_bindir" ]; then
    echo "Error Fatal : No existe la carpeta  $vmach_bindir"
    exit 1
fi

if [ ! -d /home/"$USER"/buckets ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets"
    exit 1
fi

if [ ! -d /home/"$USER"/buckets/b1 ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets/b1"
    exit 1
fi


if [ ! -f /home/"$USER"/buckets/b1/kaggle.json ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/buckets/b1/kaggle.json"
    exit 1
fi

if ! grep -q username /home/"$USER"/buckets/b1/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : username"
    exit 1
fi


if ! grep -q key /home/"$USER"/buckets/b1/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : key"
    exit 1
fi

res=$(wc -l < /home/"$USER"/buckets/b1/kaggle.json)

if [ ! "$res" = "0" ]; then
    echo "Error Fatal : el archivo kaggle.json debe tener una sola linea"
    exit 1
fi



if [ ! -f /home/"$USER"/buckets/b1/estudiante_secretos.sh ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/buckets/b1/estudiante_secretos.sh"
    exit 1
fi


# conversion a newline de Linux
rm -f /home/"$USER"/buckets/b1/estudiante_secretos.bak
mv /home/"$USER"/buckets/b1/estudiante_secretos.sh  /home/"$USER"/buckets/b1/estudiante_secretos.bak
perl -pe 's/\r\n|\r/\n/g'  /home/"$USER"/buckets/b1/estudiante_secretos.bak  > /home/"$USER"/buckets/b1/estudiante_secretos.sh
rm  -f  /home/"$USER"/buckets/b1/estudiante_secretos.bak



# verificacion de los parametros de estudiante_secretos.sh
if ! grep -q estudiante_zulip_email /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_zulip_email"
    exit 1
fi

if ! grep -q estudiante_github_usuario /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_usuario"
    exit 1
fi

if ! grep -q estudiante_github_token /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_token"
    exit 1
fi

if ! grep -q estudiante_github_email /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_email"
    exit 1
fi

if ! grep -q estudiante_github_nombre /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene el parametro  estudiante_github_nombre"
    exit 1
fi


if  ! grep -q estudiante_github_token='"'ghp_   /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_token debe comenzar con ghp_"
    exit 1
fi


if  ! grep -E -o -q "\bestudiante_github_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_email debe tener forma de email"
    exit 1
fi

if  ! grep -E -o -q "\bestudiante_zulip_email=\"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b"  /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_email debe tener forma de email"
    exit 1
fi


if  ! grep -q @   /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el estudiante_github_token debe comenzar con ghp_"
    exit 1
fi


if  grep -q “ /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q ” /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh tiene comillas dobles INCLINADAS"
    exit 1
fi

if  grep -q "'" /home/"$USER"/buckets/b1/estudiante_secretos.sh; then
    echo "Error Fatal : el archivo estudiante_secretos.sh no tiene comillas simples, y solo debe tener dobles"
    exit 1
fi




cp  /home/"$USER"/buckets/b1/estudiante_secretos.sh   "$vmach_bindir"/
chmod u+x  "$vmach_bindir"/estudiante_secretos.sh

# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  "$vmach_bindir"/estudiante_secretos.sh

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


response=$(curl -s -w "%{http_code}" -H "Authorization: Bearer $estudiante_github_token" "https://api.github.com")
http_code=$(tail -n1 <<< "$response")
if [ ! "$http_code" -eq "200" ]; then
  rm -rf  /home/"$USER"/tmp
  echo "Error Fatal: el estudiante_token_github NO es reconocido por www.github.com"
  exit 1
fi



rm -rf /home/"$USER"/.kaggle
mkdir -p /home/"$USER"/.kaggle
cp  /home/"$USER"/buckets/b1/kaggle.json   /home/"$USER"/.kaggle/
chmod 600 /home/"$USER"/.kaggle/kaggle.json


fmach_registrar_instalacion $logito