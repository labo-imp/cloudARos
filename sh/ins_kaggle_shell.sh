#!/bin/bash
# fecha revision   2026-05-18  12:02


# este script corre en Cloud Shell

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


# instalo en Cloud Shell la libreria Kaggle
pip install --user kaggle
python3 -c "import kaggle"
if [ ! $? -eq 0 ]; then
    printf  "\nError Fatal: no se ha podido instalar la libreria : kaggle \n\n"
    exit 1
fi

# bajo el archivo submit de ejemplo
wget --quiet  --tries=3  $vcur_webfiles/submit_sample.csv  -O  /home/"$USER"/tmp/submit_sample.csv
if [ ! -f  /home/"$USER"/tmp/submit_sample.csv ]; then
    printf "\nError Fatal : No se pudo bajar el archivo : submit_sample.csv \n\n"
    exit 1
fi


# submit a Kaggle
res=$(/home/"$USER"/.local/bin/kaggle competitions submit -c  $vcur_kaggle_competencia_peque -f  /home/"$USER"/tmp/submit_sample.csv  -m   "prueba automatica durante instalacion")
if [ ! "$res" = "$vcur_kaggle_submit_ok" ]; then
    echo "$res"
    echo
    printf "\nError Fatal : No se pudo hacer el submit a la competencia Kaggle, archivo kaggle.json incorrecto o no registrado en la competencia \n\n"
    exit 1
fi


exit 0