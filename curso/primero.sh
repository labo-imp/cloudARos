#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell
printf "\niniciando la instalacion\n\n"

cursonombre="$1"
cursoarch="common_""$cursonombre"".sh"

vmach_github_user="labo-imp"
vmach_github_repo="cloudARos"

# instalacion de git  y clonado del repo  -----------------

sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  install  git rsync  nala

# clono el repo de instalacion de machina
rm -rf /home/"$USER"/machina
cd /home/"$USER"  || exit 1
git clone  https://github.com/"$vmach_github_user"/"$vmach_github_repo".git   machina

# permisos de ejecucion
chmod u+x  /home/"$USER"/machina/sh/*.sh
chmod u+x  /home/"$USER"/machina/jl/*.jl
chmod u+x  /home/"$USER"/machina/direct/*.sh
chmod u+x  /home/"$USER"/machina/curso/*.sh

# PERSONALIZACION  del CURSO
# verifico existencia del curso
if [ ! -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
    echo "Error Fatal : No existe en el repo de instalacion el curso $cursonombre"
    exit 1
fi

cp  /home/"$USER"/machina/curso/"$cursoarch"  /home/"$USER"/machina/curso/common_curso.sh


gcloud secrets describe ds-curso
if [ ! $? -eq 0 ]; then
  # creo de CERO el secreto
  echo -n "$cursoarch" | gcloud secrets  create  ds-curso  --data-file=-
else
  # actualizo el secreto
  echo -n "$cursoarch" | gcloud secrets  versions add    ds-curso  --data-file=-
fi


CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud secrets add-iam-policy-binding ds-curso \
   --member="serviceAccount:$CURRENT_ACCOUNT" \
   --role="roles/secretmanager.secretAccessor" \
   --project="$MY_PROJECT_ID"




# en el archivo  ~/.cruso esta el nombre del  curso
echo  "$cursoarch"  >  /home/"$USER"/.curso

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

mkdir -p /home/"$USER"/sh
cp  /home/"$USER"/machina/sh/common_machina.sh   "$vmach_bindir"/common.sh
cat /home/"$USER"/machina/curso/common_curso.sh  >> "$vmach_bindir"/common.sh

#------------------
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/curso/common_curso.sh

timestamp=$(date +"%y%m%d%H%M%S%3N")
projectid_nuevo="$vcur_gcprojprefix""$timestamp"

# creo proyecto nuevo
listaprojectos=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE")
echo "$listaprojectos"
echo

# creo el project  si no existe ninguno
if [ "$listaprojectos" = "" ];
then
    printf "\ncreando proyecto\n"
    gcloud projects create "$projectid_nuevo" --name="$vcur_gcprojname"
    sleep 60
    printf "\nEsperando para la creacion del proyecto \n\n"
    printf "\nproyecto $projectid_nuevo creado\n"
fi


MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
printf "\n $MY_PROJECT_ID \n"

gcloud config set project "$MY_PROJECT_ID"

gcloud projects update "$MY_PROJECT_ID"  --name="$vcur_gcprojname"


# habilitacion de servicios
gcloud --quiet --project="$MY_PROJECT_ID" services enable  iam.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  cloudapis.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  cloudresourcemanager.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  iamcredentials.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  storage-api.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  storage-component.googleapis.com
gcloud --quiet --project="$MY_PROJECT_ID" services enable  storage.googleapis.com

printf "\nesperando para establecer billing\n"
sleep  30
MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
accountid=$(gcloud alpha billing accounts list  --format="value(ACCOUNT_ID)")
gcloud beta billing projects link "$MY_PROJECT_ID" --billing-account="$accountid"  --project="$MY_PROJECT_ID"

printf "\ndando permisos de Compute\n"
gcloud --quiet --project="$MY_PROJECT_ID" services enable  compute.googleapis.com

printf "\ndando permisos de Secret Manager\n"
gcloud --quiet --project="$MY_PROJECT_ID" services enable  secretmanager.googleapis.com

gcloud projects add-iam-policy-binding  "$MY_PROJECT_ID" \
  --member="serviceAccount:$CURRENT_ACCOUNT" \
  --role="roles/secretmanager.admin" 


MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud projects add-iam-policy-binding "$MY_PROJECT_ID" \
  --member="serviceAccount:$CURRENT_ACCOUNT" \
  --role="roles/compute.instanceAdmin.v1"



# verifico que existan buckets, sino creo el primero

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

mybuckets=$(/bin/gsutil ls)

if [ "$mybuckets" = "" ];
then
    printf "\nNo existen buckets, se creara uno \n\n"
    gcloud storage buckets create gs://"$USER"_bukito2026  \
      --project "$MY_PROJECT_ID"  \
      --location=NORTHAMERICA-NORTHEAST2  \
      --public-access-prevention \
      --enable-hierarchical-namespace \
      --uniform-bucket-level-access
fi

cd /home/"$USER"  || exit 1


# personalizacion del curso
gcloud secrets describe ds-curso
if [ ! $? -eq 0 ]; then
  # creo de CERO el secreto
  echo -n "$cursoarch" | gcloud secrets  create  ds-curso  --data-file=-
else
  # actualizo el secreto
  echo -n "$cursoarch" | gcloud secrets  versions add    ds-curso  --data-file=-
fi


CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud secrets add-iam-policy-binding ds-curso \
   --member="serviceAccount:$CURRENT_ACCOUNT" \
   --role="roles/secretmanager.secretAccessor" \
   --project="$MY_PROJECT_ID"


# private keys
rm -rf /home/"$USER"/.ssh
mkdir -p /home/"$USER"/.ssh
ssh-keygen -t rsa -f  /home/"$USER"/.ssh/google_compute_engine -C "$USER"  -q -N ""




echo "Esperando 5 segundos"
sleep 5
printf "\n\nHa finalizado la primera parte. Continua con la copia de archivos al bucket.\n\n"
