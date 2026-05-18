#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell
printf "\nCreando Templates\n\n"

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

fcur_project_id
MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"


# Creacion de copia de imagen (por BUG en gc)----------------------------------

gcloud compute images describe "$vcur_gcexternal_image_name" --project "$MY_PROJECT_ID" > /dev/null 2>&1
if [ $? -eq 0 ]; then
  gcloud compute --quiet images delete "$vcur_gcexternal_image_name"
fi   


# lanzo en BACKGROUND la creacion de la copia de la imagen
gcloud compute images create "$vcur_gcexternal_image_name" \
  --source-image-family="$vcur_gcexternal_image_family" \
  --source-image-project="$vcur_gcexternal_image_project" \
  --storage-location=northamerica-northeast2   &



# Apertura de Puertos de red tcp ----------------------------------------------
# Documentacion  https://cloud.google.com/vpc/docs/using-firewalls#gcloud

gcloud compute firewall-rules describe jupyter --project "$MY_PROJECT_ID" > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  gcloud compute firewall-rules create jupyter \
    --allow tcp:8888 --source-ranges=0.0.0.0/0 \
    --description="jupyter" \
    --project="$MY_PROJECT_ID" \
    --target-tags=jupyter-server 
fi

gcloud compute firewall-rules describe xrdp --project "$MY_PROJECT_ID" > /dev/null 2>&1
if [ ! $? -eq 0 ]; then
  gcloud compute firewall-rules create xrdp \
    --allow tcp:3389 --source-ranges=0.0.0.0/0 \
    --description="xrdp" \
    --project="$MY_PROJECT_ID" \
     --target-tags=rdp-server  
fi

# Creacion de desktop-jr -------------------------------------------------------

gcloud compute instances describe desktop-jr --zone=northamerica-northeast2-b  > /dev/null 2>&1
if [ $? -eq 0 ]; then
  gcloud beta compute --quiet instances delete desktop-jr \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b
fi


myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)

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
    --reservation-affinity=any



printf  "\n\nEsperando 240 segundos para apagar desktop-jr.\n"
sleep 240

# detengo la  vm desktop-jr
gcloud beta compute instances stop --async  desktop-jr \
    --project="$MY_PROJECT_ID" \
    --zone=northamerica-northeast2-b 


# Creacion de Templates -------------------------------------------------------

crear_template() {
  local par_nombre=$1
  local par_tipo=$2
  local par_region=$3 

  gcloud beta compute instance-templates delete "$par_nombre" --region="$par_region" --quiet  --verbosity=none  --project="$MY_PROJECT_ID"

  gcloud beta compute instance-templates create "$par_nombre" \
    --project="$MY_PROJECT_ID" \
    --machine-type="$par_tipo" \
    --network-interface=network=default,network-tier=PREMIUM \
    --no-restart-on-failure --maintenance-policy=TERMINATE \
    --provisioning-model=SPOT \
    --instance-termination-action=DELETE \
    --service-account="$myserviceaccount" \
    --scopes=cloud-platform \
    --tags=https-server,http-server,jupyter-server,rdp-server \
    --instance-template-region="$par_region" \
    --image-family="$te_image_family" \
    --image-project="$te_image_project" \
    --boot-disk-size="$te_boot_disk_size" \
    --boot-disk-type=pd-standard \
    --boot-disk-device-name="$par_nombre" \
    --shielded-secure-boot \
    --shielded-integrity-monitoring --reservation-affinity=any \
    --metadata-from-file shutdown-script=/home/"$USER"/machina/direct/shutdown-script.sh
}

myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)


te_boot_disk_size=256
te_image_project="$vcur_gcexternal_image_project"
te_image_family="$vcur_gcexternal_image_family"

crear_template  to-032ram-08vcpu   e2-custom-8-32768        northamerica-northeast2  # usd 25
crear_template  to-064ram-08vcpu   e2-custom-8-65536        northamerica-northeast2  # usd 32
crear_template  to-096ram-12vcpu   e2-custom-12-98304       northamerica-northeast2  # usd 40

crear_template  to-128ram-08vcpu   n2-custom-8-131072-ext   northamerica-northeast2  # usd 98
crear_template  to-128ram-12vcpu   n2-custom-12-131072-ext  northamerica-northeast2  # usd 95

crear_template  to-256ram-08vcpu   n2-custom-8-262144-ext   northamerica-northeast2  # usd 202
crear_template  to-256ram-12vcpu   n2-custom-12-262144-ext  northamerica-northeast2  # usd 198

crear_template  to-512ram-08vcpu   n2-custom-8-524288-ext   northamerica-northeast2  # usd 409
crear_template  to-512ram-12vcpu   n2-custom-12-524288-ext  northamerica-northeast2  # usd 405

#---------------------------------------
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

myserviceaccount=$(gcloud iam service-accounts list --format='value(EMAIL)' | head -1)


gcloud beta compute instance-templates delete te-generica --region=northamerica-northeast2 --quiet  --verbosity=none  --project="$MY_PROJECT_ID"

gcloud beta compute instance-templates create te-generica \
  --project="$MY_PROJECT_ID" \
  --machine-type=e2-custom-12-98304 \
  --network-interface=network=default,network-tier=PREMIUM,stack-type=IPV4_ONLY \
  --no-restart-on-failure \
  --maintenance-policy=TERMINATE \
  --provisioning-model=SPOT \
  --instance-termination-action=DELETE \
  --service-account="$myserviceaccount" \
  --scopes=cloud-platform \
  --tags=https-server,http-server,jupyter-server,rdp-server \
  --instance-template-region=northamerica-northeast2 \
  --image="projects/$MY_PROJECT_ID/global/images/$vcur_gcexternal_image_name" \
  --boot-disk-size=256 \
  --boot-disk-type=pd-standard \
  --boot-disk-device-name=te-generica \
  --shielded-secure-boot \
  --shielded-integrity-monitoring \
  --reservation-affinity=none \
  --metadata-from-file shutdown-script=/home/"$USER"/machina/direct/shutdown-script.sh


echo "Esperando 5 segundos"
sleep 5
printf "\n\nEnhorabuena ! Ha termiando toda la instalacion..\n\n"
