#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/$USER/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/$USER/machina/curso/common_curso.sh

printf  "\n\nIniciando la parte final de la instalacion\n"

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project $MY_PROJECT_ID


# apago instance-instalacion
printf "\n Apgando instance-instalacion, demora  1 minuto\n"
gcloud --quiet compute instances stop instance-instalacion --zone=northamerica-northeast2-b --project=$MY_PROJECT_ID


# creo una copia de la imagen vieja
timestamp=$(date +"%y%m%d%H%M")
gcloud compute images create "$vmach_gcimagename"-"$timestamp"  \
       --project="$MY_PROJECT_ID" \
       --family="$vmach_gcimagefamily" \
       --source-image="$vmach_gcimagename" \
       --source-image-project="$MY_PROJECT_ID" \
       --storage-location=northamerica-northeast2

# borro la imagen vieja
printf "\n borrando imagen image-dm vieja en caso que hubiera quedado como resabio de intento de instalacion anterior\n\n"
gcloud --quiet compute images delete "$vmach_gcimagename"  --quiet  --verbosity=none  --project=$MY_PROJECT_ID


printf  "\n\nCreando la imagen del sistema operativo, esto va a demorar 6 minutos.\n"
printf  "Le va a parecer que no se esta haciendo nada, pero ESPERE esos 6 minutos ! \nNo se impaciente ! \n\n"

gcloud compute images create "$vmach_gcimagename"  \
       --project="$MY_PROJECT_ID" \
       --family="$vmach_gcimagefamily" \
       --source-disk=instance-instalacion \
       --source-disk-zone=northamerica-northeast2-b \
       --storage-location=northamerica-northeast2


printf  '\nun gran paso : imagen creada.\n\n'

# permisos universales para que todos usen la imagen
gcloud compute images add-iam-policy-binding "$vmach_gcimagename" \
    --project=$MY_PROJECT_ID \
    --member='allAuthenticatedUsers' \
    --role='roles/compute.imageUser'
