#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell
printf "\niniciando la instalacion\n\n"

cursonombre="$1"
cursoarch="common_""$cursonombre"".sh"

# parametros fundamentales
vmach_github_user="labo-imp"
vmach_github_repo="cloudARos"


sudo  DEBIAN_FRONTEND=noninteractive  apt-get update

rm -rf  "$vmach_bindir"
mkdir  -p  "$vmach_bindir"
mkdir  -p  "$vmach_logdir"

sudo  apt-get --yes  install  git rsync  nala

# clono el repo de instalacion
rm -rf /home/"$USER"/machina
cd  /home/"$USER" || exit 1
git clone  https://github.com/"$vmach_github_user"/"$vmach_github_repo".git   machina

# permisos de ejecucion
chmod u+x  /home/"$USER"/machina/curso/*.sh
chmod u+x  /home/"$USER"/machina/sh/*.sh
chmod u+x  /home/"$USER"/machina/jl/*.jl
chmod u+x  /home/"$USER"/machina/direct/*.sh

# PERSONALIZACION  del CURSO
# verifico existencia del curso
if [ ! -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
    echo "Error Fatal : No existe en el repo de instalacion el curso $cursonombre"
    exit 1
fi

cp  /home/"$USER"/machina/curso/"$cursoarch"  /home/"$USER"/machina/curso/common_curso.sh


source /home/"$USER"/machina/sh/common_machina.sh

# despersonalizacion
cp /home/"$USER"/machina/sh/common_machina.sh   "$vmach_bindir"/common.sh
cat /home/"$USER"/machina/curso/common_curso.sh  >>  "$vmach_bindir"/common.sh


# copia de direct
cp /home/"$USER"/machina/direct/*   "$vmach_bindir"/

# tmux vim
/home/"$USER"/machina/sh/ins_tool_vimtmux.sh


#------------------------------------------------------------------------------

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


# timestamp=$(date +"%y%m%d%H%M%S%3N")
projectid_nuevo="$vmach_gcprojprefix"

# creo proyecto nuevo
listaprojectos=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE")
echo "$listaprojectos"
echo


if [ "$listaprojectos" = "" ];
then
    printf "\ncreando proyecto\n"
    gcloud projects create "$projectid_nuevo" --name="$vmach_gcprojname"
    sleep 30
    printf "\nproyecto $projectid_nuevo creado\n"
fi


gcloud projects update "$projectid_nuevo"  --name="$vmach_gcprojname"



# gcloud config set account "$projectid_nuevo"
MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
printf "\n$MY_PROJECT_ID\n"

gcloud config set project "$MY_PROJECT_ID"
printf "\n$MY_PROJECT_ID\n"


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
MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
accountid=$(gcloud alpha billing accounts list  --format="value(ACCOUNT_ID)")
gcloud beta billing projects link "$MY_PROJECT_ID" --billing-account="$accountid"  --project="$MY_PROJECT_ID"

printf "\ndando permisos de Compute\n"
gcloud --quiet --project="$MY_PROJECT_ID" services enable  compute.googleapis.com

printf "\ndando permisos de Secret Manager\n"
gcloud --quiet --project="$MY_PROJECT_ID" services enable  secretmanager.googleapis.com

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

# clave usuario ds
echo -n "Aristoteles01" | gcloud secrets  create  ds-password  --data-file=-

CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud projects add-iam-policy-binding  "$MY_PROJECT_ID" \
  --member="serviceAccount:$CURRENT_ACCOUNT" \
  --role="roles/secretmanager.admin" 

CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud secrets add-iam-policy-binding ds-password \
   --member="serviceAccount:$CURRENT_ACCOUNT" \
   --role="roles/secretmanager.secretAccessor"

CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud projects add-iam-policy-binding "$MY_PROJECT_ID" \
  --member="serviceAccount:$CURRENT_ACCOUNT" \
  --role="roles/compute.instanceAdmin.v1"


# reglas del FireWall
gcloud --quiet compute firewall-rules delete jupyter
gcloud compute firewall-rules create jupyter \
  --allow tcp:8888 --source-ranges=0.0.0.0/0 \
  --description="jupyter" \
  --project="$MY_PROJECT_ID" \
  --target-tags=jupyter-server 


gcloud --quiet compute firewall-rules delete xrdp
gcloud compute firewall-rules create xrdp \
  --allow tcp:3389 --source-ranges=0.0.0.0/0 \
  --description="xrdp" \
  --project="$MY_PROJECT_ID" \
  --target-tags=rdp-server  


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



sleep  5


# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"


myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)



# instance-instalacion SPOT creacion
gcloud beta compute instances create instance-instalacion \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b \
    --machine-type=e2-standard-8 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --no-restart-on-failure \
    --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --preemption-notice-duration=120s \
    --instance-termination-action=STOP \
    --service-account="$myserviceaccount" \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=https-server,http-server,jupyter-server,rdp-server \
    --create-disk=auto-delete=yes,boot=yes,device-name=instance-instalacion,image=projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2604-resolute-amd64-v20260516,mode=rw,size=64,type=pd-standard \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=none


# verifico que existan buckets, sino creo el primero

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

mybuckets=$(/bin/gsutil ls)
echo "$mybuckets"

if [ "$mybuckets" = "" ];
then
    printf "\nNo existen buckets, se creara uno \n\n"
    gcloud storage buckets create gs://"$USER"_bukitom1  \
      --project "$MY_PROJECT_ID"  \
      --location=NORTHAMERICA-NORTHEAST2  \
      --public-access-prevention  \
      --enable-hierarchical-namespace \
      --uniform-bucket-level-access
fi


echo
echo "Esperando 30 segundos a que se inicie la virtual machine  instance-instalacion"
sleep 30


rm -rf /home/"$USER"/.ssh
mkdir -p /home/"$USER"/.ssh
ssh-keygen -t rsa -f  /home/"$USER"/.ssh/google_compute_engine -C "$USER"  -q -N ""

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

sleep 10

gcloud --quiet compute ssh "$USER"@instance-instalacion \
    --zone=northamerica-northeast2-b\
    --project="$MY_PROJECT_ID" \
    --command="bash -s $cursoarch" < /home/"$USER"/machina/sh/zmachOne_start1.sh

echo "Esperando 5 segundos"
sleep 5
printf "\n\nHa finalizado la pre instalacion. Continua con la copia de archivos al bucket.\n\n"