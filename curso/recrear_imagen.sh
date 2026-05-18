#!/bin/bash
# fecha revision   2026-05-18  12:02

printf "\nRecrear imagen\n\n"

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"


gcloud compute --quiet images delete "$vcur_gcexternal_image_name"

gcloud compute images create "$vcur_gcexternal_image_name" \
  --source-image-family="$vcur_gcexternal_image_family" \
  --source-image-project="$vcur_gcexternal_image_project"

