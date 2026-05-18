#!/bin/bash
# fecha revision   2026-05-18  12:02

vcur_gcprojprefix="proj-austral-"
vcur_gcprojname="Austral Labo1"


vcur_gcexternal_image_project="machinae"
vcur_gcexternal_image_family="labo-family"
vcur_gcexternal_image_name="labo-image"


vcur_webfiles="https://storage.googleapis.com/open-courses/austral2026-5da5/labo1"


vcur_dataset1="gerencial_competencia_2026.csv.gz"
vcur_dataset2="analistajr_competencia_2026.csv.gz"
vcur_dataset3="analistasr_competencia_2026.csv.gz"
vcur_dataset4="dataset_pequeno.csv"
vcur_pseudopublic="list"

export vcur_zulipbot="GoogleCloud-bot@austral2026.zulip.rebelare.com:bdkv78YBuvuHSc8E5ICejz0aXg7ol9tR"
export vcur_zulipurl="https://austral2026.zulip.rebelare.com/api/v1/messages"


vcur_kaggle_archivoprueba="submit_sample.csv"

vcur_kaggle_competencia_peque="labo-1-rosario-inicial"
vcur_kaggle_competencia_sr="labo-1-rosario-2026-analista-sr"
vcur_kaggle_competencia_jr="labo-1-rosario-2026-analista-jr"
vcur_kaggle_competencia_mgr="labo-1-rosario-2026-analista-mgr"
vcur_kaggle_submit_ok="Successfully submitted to Labo 1 Rosario Inicial"

export vcur_github_catedra_user="labo-imp"
export vcur_github_catedra_repo="labo2026ros"

export vcur_repo_catedra_destino=/home/"$USER"
export vcur_repo_estudiante_destino="/home/$USER/buckets/b1"



export vcur_mlflow_usuario="labo2026ros"
export vcur_mlflow_clave="constructivism"

vcur_repo_check_directory="src/arboles"
vcur_repo_check_file="z102_FinalTrain.ipynb"


# grabo
fcur_project_id() {
  proj_mach=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
  if [ ! "$proj_mach" = "" ];
  then
    echo  "$proj_mach"
  else
    proj_cur=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
    echo  "$proj_cur"
  fi
}
