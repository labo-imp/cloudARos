#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

cd /home/"$USER"  || exit 1

if [ ! -f /home/"$USER"/tmp/kaggle.json ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/tmp/kaggle.json"
    exit 1
fi


if ! grep -q username /home/"$USER"/tmp/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : username"
    exit 1
fi


if ! grep -q key /home/"$USER"/tmp/kaggle.json; then
    echo "Error Fatal : el archivo kaggle.json no tiene la palabra : key"
    exit 1
fi

res=$(wc -l < /home/"$USER"/tmp/kaggle.json)

if [ ! "$res" = "0" ]; then
    echo "Error Fatal : el archivo kaggle.json debe tener una sola linea"
    exit 1
fi



rm -rf /home/"$USER"/.kaggle
mkdir -p /home/"$USER"/.kaggle
cp  /home/"$USER"/tmp/kaggle.json   /home/"$USER"/.kaggle/
chmod 600 /home/"$USER"/.kaggle/kaggle.json

#--------------------------------------
# instalacion  uv
curl -LsSf https://astral.sh/uv/install.sh | sh

export PATH="$PATH:/home/$USER/.local/bin"
echo  "export PATH=/home/\$USER/.local/bin:\$PATH"  >>  /home/"$USER"/.bashrc
chmod u+x /home/"$USER"/.bashrc
source /home/"$USER"/.bashrc 


sudo  apt-get update

if [ ! -d  /home/"$USER"/.venv ]; then
  uv venv  .venv --python 3.14
fi

# activo python 3.14
source /home/"$USER"/.venv/bin/activate


# actualizo  pip
uv cache clean
uv pip install --upgrade pip
uv pip install setuptools
uv pip install -U setuptools wheel


# instalo paquetes iniciales de Python
uv pip install  kaggle  zulip


# Hago submit a kaggle

# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

cd  /home/"$USER"/tmp || exit 1


if [ ! -e "$vcur_kaggle_archivoprueba" ]; then
  wget --quiet --tries=3  "$vcur_webfiles"/"$vcur_kaggle_archivoprueba"  -O  "$vcur_kaggle_archivoprueba"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_kaggle_archivoprueba"
  fi
fi


echoerr() { printf "\033[0;31m%s\n\033[0m" "$*" >&2; }

if [ ! -f "$vcur_kaggle_archivoprueba" ]; then
    echoerr  no existe el archivo  "$vcur_kaggle_archivoprueba"
    echo 0.0
    exit 1
fi


comentario="prueba de kaggle verificar"

# Suhbmit a Kaggle
res=$(kaggle competitions submit -c  $vcur_kaggle_competencia_peque \
 -f  $vcur_kaggle_archivoprueba \
 -m   "$comentario")


if [ ! "$res" = "$vcur_kaggle_submit_ok" ]; then
    echo "$res"
    echo
    printf "\nError Fatal : No se pudo hacer el submit a la competencia Kaggle, archivo kaggle.json incorrecto o no registrado en la competencia \n\n"
    exit 1
fi



exit 0
