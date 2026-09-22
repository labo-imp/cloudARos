#!/bin/bash
# fecha revision   2026-09-14  17:47

vcur_gcprojprefix="proj-uba-"
vcur_gcprojname="UBA DMEyF"


vcur_gcexternal_image_project="machinae"
vcur_gcexternal_image_family="labo-family"
vcur_gcexternal_image_name="labo-image"


vcur_webfiles="https://storage.googleapis.com/open-courses/dmeyf2026-9c6f"


vcur_dataset1="comptetencia_01_crudo.csv"
vcur_dataset2="comptetencia_02_crudo.csv.gz"
vcur_dataset3="comptetencia_02_crudo.csv.gz"
vcur_dataset4="comptetencia_02_crudo.csv.gz"
vcur_pseudopublic="list"

export vcur_zulipbot="GoogleCloud-bot@uba26.zulip.rebelare.com:oaCRIw3i6jxWQKhT116pdoje03tYsUoc"
export vcur_zulipurl="https://uba26.zulip.rebelare.com/api/v1/messages"


export vcur_github_catedra_user="dmecoyfin"
export vcur_github_catedra_repo="dmeyf2026"

export vcur_repo_catedra_destino=/home/"$USER"
export vcur_repo_estudiante_destino="/home/$USER/buckets/b1"



export vcur_mlflow_usuario="dmeyf2026"
export vcur_mlflow_clave="constructivism"

vcur_repo_check_directory="src/arboles"
vcur_repo_check_file="z0201_ComparandoModelos.ipynb"


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
