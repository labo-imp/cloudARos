#!/bin/bash

# corre en Cloud Shell

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

gcloud compute ssh ds@instance-instalacion \
    --zone=northamerica-northeast2-b \
    --project="$MY_PROJECT_ID" \
    --command="bash -s" <  /home/"$USER"/machina/sh/zmachOne_start2.sh
