#!/bin/bash
# fecha revision   2026-09-14  17:47

#!/bin/bash
# fecha revision   2026-09-14  17:47

# este script corre en Cloud Shell
printf "\niniciando la creacion de desktop-jr\n\n"

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


# en el archivo  ~/.cruso esta el nombre del  curso
echo  "$cursoarch"  >  /home/"$USER"/.curso

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

mkdir -p /home/"$USER"/sh
cp  /home/"$USER"/machina/sh/common_machina.sh   "$vmach_bindir"/common.sh
cat /home/"$USER"/machina/curso/common_curso.sh  >> "$vmach_bindir"/common.sh


# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


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


# Creacion de desktop-jr -------------------------------------------------------

cp /home/"$USER"/machina/direct/setear_project.sh   /home/"$USER"/sh/setear_project.sh 
sed -i  's/miproyecto/'"$MY_PROJECT_ID"'/g'  /home/"$USER"/sh/setear_project.sh 
chmod u+x  /home/"$USER"/sh/setear_project.sh 

gcloud compute instances describe desktop-jr --zone=northamerica-northeast2-b  > /dev/null 2>&1
if [ $? -eq 0 ]; then
  gcloud beta compute --quiet instances delete desktop-jr \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b
fi


myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)
echo $myserviceaccount


# Creacion de desktop-jr
gcloud beta compute instances create desktop-jr \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b \
    --machine-type=e2-highmem-8 \
    --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account="$myserviceaccount" \
    --scopes=https://www.googleapis.com/auth/cloud-platform \
    --tags=https-server,http-server,jupyter-server,rdp-server \
    --image-family="$vcur_gcexternal_image_family" \
    --image-project="$vcur_gcexternal_image_project" \
    --boot-disk-size=256 \
    --boot-disk-type=pd-standard \
    --boot-disk-device-name=desktop-jr \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=goog-ec-src=vm_add-gcloud \
    --reservation-affinity=any \
    --metadata-from-file=startup-script=/home/"$USER"/sh/setear_project.sh 


printf  "\n\nEsperando 240 segundos para apagar desktop-jr.\n"
sleep 240

# detengo la  vm desktop-jr
gcloud beta compute instances stop --async  desktop-jr \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b 

echo "Esperando 5 segundos"
sleep 5
printf "\n\nHa termiando la creacion de desktop-jr..\n"
printf "\n\nTen cuidado de no borrarla..\n\n"
