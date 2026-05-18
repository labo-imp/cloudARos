#!/bin/bash
# fecha revision   2026-05-18  12:02

vcur_gcprojprefix="proj-austral-"
vcur_gcprojname="Austral Labo1"


vcur_gcexternal_image_project="machinae"
vcur_gcexternal_image_family="labo-family"
vcur_gcexternal_image_name="labo-image"


vcur_webfiles="https://storage.googleapis.com/open-courses/austral2026-5da5/labo3"


vcur_dataset1="sell-in.txt.gz"
vcur_dataset2="tb_productos.txt"
vcur_dataset3="tb_stocks.txt"
vcur_dataset4="product_id_apredecir201912.txt"
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
export vcur_github_catedra_repo="labo3-2026r"

export vcur_repo_catedra_destino=/home/"$USER"
export vcur_repo_estudiante_destino="/home/$USER/buckets/b1"



export vcur_mlflow_usuario="labo2026ros"
export vcur_mlflow_clave="constructivism"

vcur_repo_check_directory="src/naif"
vcur_repo_check_file="z211_Naif.ipynb"


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
