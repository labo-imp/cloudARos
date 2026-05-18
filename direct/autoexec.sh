#!/bin/bash

# corre con los services y  direct actualizados
# corre con los buckets montados

# 1. copia secretos
# 2. recrea (fantasmitas)  o actualiza (desktops)  repos

# permito el rdp
sudo systemctl enable --now xrdp
sudo systemctl start xrdp

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

if [ ! -d /home/"$USER"/buckets ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets"
    exit 1
fi

if [ ! -d /home/"$USER"/buckets/b1 ]; then
    echo "Error Fatal : No existe la carpeta  /home/$USER/buckets/b1"
    exit 1
fi


if [ ! -f /home/"$USER"/buckets/b1/estudiante_secretos.sh ]; then
    echo "Error Fatal : No existe el archivo  /home/$USER/buckets/b1/estudiante_secretos.sh"
    exit 1
fi


# conversion a newline de Linux
rm  -f /home/"$USER"/buckets/b1/estudiante_secretos.bak
mv /home/"$USER"/buckets/b1/estudiante_secretos.sh  /home/"$USER"/buckets/b1/estudiante_secretos.bak
perl -pe 's/\r\n|\r/\n/g'  /home/"$USER"/buckets/b1/estudiante_secretos.bak  > /home/"$USER"/buckets/b1/estudiante_secretos.sh
rm  -f /home/"$USER"/buckets/b1/estudiante_secretos.bak


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


cp  /home/"$USER"/buckets/b1/estudiante_secretos.sh   "$vmach_bindir"/
chmod u+x  "$vmach_bindir"/estudiante_secretos.sh


# necesito ambos sets de variables de entorno
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  /home/"$USER"/buckets/b1/estudiante_secretos.sh


# clonado de repos
if [[ "$MIHOST" == "desktop-jr" ]] || [[ "$MIHOST" == "desktop-sr" ]]
then
  /home/"$USER"/machina/direct/actualizar_repo_principal.sh
  /home/"$USER"/machina/direct/actualizar_repos_auxiliares.sh
else
  # es un fantasmita  clono todo de cero
  # /home/"$USER"/machina/direct/clonar_usuario.sh
  /home/"$USER"/machina/direct/clonar_catedra.sh
fi

#------------------------------------------------------------------------------
# Datasets, reintento si estan los nuevos

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"
CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
  
# parche para el nombre del curso para labo1r
gcloud secrets describe  ds-curso
if [ ! $? -eq 0 ]; then
  # creo de CERO el secreto
 
  echo "common_labo1r.sh" | gcloud secrets  create  ds-curso  --data-file=-

  gcloud secrets add-iam-policy-binding   ds-curso \
    --member="serviceAccount:$CURRENT_ACCOUNT" \
    --role="roles/secretmanager.secretAccessor" \
    --project="$MY_PROJECT_ID"
fi



mkdir -p /home/"$USER"/datasets/
cd /home/"$USER"/datasets/  || exit 1
find . -type f -size 0b -delete

mkdir -p /home/"$USER"/buckets/b1/datasets
cd  /home/"$USER"/buckets/b1/datasets  || exit 1
find . -type f -size 0b -delete


if [ ! -e "$vcur_dataset1" ]; then
  wget --quiet  --tries=3  "$vcur_webfiles"/"$vcur_dataset1"  -O  "$vcur_dataset1"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset1"
  fi
fi

if [ ! -e "$vcur_dataset2" ]; then
  wget --quiet  --tries=3  "$vcur_webfiles"/"$vcur_dataset2"  -O  "$vcur_dataset2"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset2"
  fi
fi


if [ ! -e "$vcur_dataset3" ]; then
  wget --quiet  --tries=3  "$vcur_webfiles"/"$vcur_dataset3"  -O  "$vcur_dataset3"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset3"
  fi
fi


if [ ! -e "$vcur_dataset4" ]; then
  wget --quiet --tries=3  "$vcur_webfiles"/"$vcur_dataset4"  -O  "$vcur_dataset4"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset4"
  fi
fi


rsync -av  /home/"$USER"/buckets/b1/datasets/  /home/"$USER"/datasets/

# Ejecuto verificacion de salud de la vm
curl -s "$vcur_webfiles"/health-check.sh   | bash   > /dev/null 2>&1
