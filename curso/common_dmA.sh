#!/bin/bash
# fecha revision   2026-09-14  17:47

vcur_gcprojprefix="proj-itba-"
vcur_gcprojname="ITBA Data Mining"


vcur_gcexternal_image_project="machinae"
vcur_gcexternal_image_family="labo-family"
vcur_gcexternal_image_name="labo-image"


vcur_webfiles="https://storage.googleapis.com/open-courses/itba2026-7c9a/dm"


vcur_dataset1="gerencial_competencia_2026.csv.gz"
vcur_dataset2="analistajr_competencia_2026.csv.gz"
vcur_dataset3="analistasr_competencia_2026.csv.gz"
vcur_dataset4="dataset_pequeno.csv"
vcur_pseudopublic="list"

export vcur_zulipbot="GoogleCloud-bot@itba2026.zulip.rebelare.com:MSzK1WHKKSTYkOaSjVpp23umpv7qBNEF"
export vcur_zulipurl="https://itba2026.zulip.rebelare.com/api/v1/messages"


vcur_kaggle_archivoprueba="submit_sample.csv"

vcur_kaggle_competencia_peque="data-mining-inicial-2026-a"
vcur_kaggle_competencia_sr="data-mining-2026-a-analista-sr"
vcur_kaggle_competencia_jr="data-mining-2026-a-analista-jr"
vcur_kaggle_competencia_mgr="data-mining-2026-a-analista-mgr"
vcur_kaggle_submit_ok="Successfully submitted to Data Mining, Inicial 2026 A"

export vcur_github_catedra_user="itba-ecd"
export vcur_github_catedra_repo="dm2026a"

export vcur_repo_catedra_destino=/home/"$USER"
export vcur_repo_estudiante_destino="/home/$USER/buckets/b1"



export vcur_mlflow_usuario="dm2026a"
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
