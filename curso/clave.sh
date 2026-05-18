#!/bin/bash
# fecha revision   2026-05-18  12:02


# shellcheck source=SCRIPTDIR/../sh/common_machine.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"


gcloud secrets describe ds-password
if [ ! $? -eq 0 ]; then
  # creo de CERO el secreto
  echo -n "$1" | gcloud secrets  create  ds-password  --data-file=-
else
  # actualizo el secreto
  echo -n "$1" | gcloud secrets  versions add    ds-password  --data-file=-
fi


CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud secrets add-iam-policy-binding ds-password \
   --member="serviceAccount:$CURRENT_ACCOUNT" \
   --role="roles/secretmanager.secretAccessor" \
   --project="$MY_PROJECT_ID"


echo "Esperando 5 segundos"
sleep 5
printf "\n\nSe ha asignado la clave. Continua la creación de templates.\n\n"
