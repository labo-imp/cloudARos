#!/bin/bash

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

# cargo el nuevo kaggle.json
rm -rf /home/"$USER"/.kaggle
mkdir -p /home/"$USER"/.kaggle


# actualizo el kaggle.json
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project  "$MY_PROJECT_ID"

/usr/bin/gcloud secrets versions access latest --secret="kaggle-cred"  --out-file=/home/"$USER"/.kaggle/kaggle.json
chmod 600 /home/"$USER"/.kaggle/kaggle.json


if [ ! -d /home/"$USER"/buckets ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets"
    exit 1
fi

if [ ! -d /home/"$USER"/buckets/b1 ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets/b1"
    exit 1
fi


if [ ! -f /home/"$USER"/buckets/b1/kaggle.json ]; then
    echo "Warning : No existe el archivo  /home/$USER/buckets/b1/kaggle.json"
    echo "Nada para actualizar"
    exit 0
fi

# Si llegue aqui, EXISTE  /home/"$USER"/buckets/b1/kaggle.json

# cargo el nuevo kaggle.json
rm -rf /home/"$USER"/.kaggle
mkdir -p /home/"$USER"/.kaggle

# muevo del bucket, DEJA DE EXISTIR en el bucket
mv  /home/"$USER"/buckets/b1/kaggle.json   /home/"$USER"/.kaggle/
chmod 600 /home/"$USER"/.kaggle/kaggle.json

# actualizo la version del secret
gcloud secrets  versions add  kaggle-cred  --data-file=/home/"$USER"/.kaggle/kaggle.json
