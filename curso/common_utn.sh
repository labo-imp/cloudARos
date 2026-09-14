#!/bin/bash
# fecha revision   2026-09-14  17:47

vcur_gcprojprefix="proj-utn-"
vcur_gcprojname="UTN DMEyF"


vcur_gcexternal_image_project="machinae"
vcur_gcexternal_image_family="labo-family"
vcur_gcexternal_image_name="labo-image"


vcur_webfiles="https://storage.googleapis.com/open-courses/utn2026-b40a"


vcur_dataset1="gerencial_competencia_2026.csv.gz"
vcur_dataset2="analistajr_competencia_2026.csv.gz"
vcur_dataset3="analistasr_competencia_2026.csv.gz"
vcur_dataset4="dataset_pequeno.csv"
vcur_pseudopublic="list"

export vcur_zulipbot="GoogleCloud-bot@utn2026.zulip.rebelare.com:MSzK1WHKKSTYkOaSjVpp23umpv7qBNEF"
export vcur_zulipurl="https://utn2026.zulip.rebelare.com/api/v1/messages"


vcur_kaggle_archivoprueba="submit_sample.csv"

vcur_kaggle_competencia_peque="utn-2026-inicial"
vcur_kaggle_competencia_sr="utn-2026-virtual-sr"
vcur_kaggle_competencia_jr="utn-2026-virtual-jr"
vcur_kaggle_competencia_mgr="utn-2026-virtual-mgr"
vcur_kaggle_submit_ok="Successfully submitted to UTN 2026 Inicial"

export vcur_github_catedra_user="utnds"
export vcur_github_catedra_repo="dmeyf2026"

export vcur_repo_catedra_destino=/home/"$USER"
export vcur_repo_estudiante_destino="/home/$USER/buckets/b1"



export vcur_mlflow_usuario="dmeyf2026"
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
