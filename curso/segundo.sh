#!/bin/bash
# fecha revision   2026-05-18  12:02

# este script corre en Cloud Shell
printf "\nVerificando kaggle.json y estudiante_secretos.sh\n\n"

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

rm -rf /home/"$USER"/tmp
mkdir -p  /home/"$USER"/tmp

# el unico bucket que existe
bucket=$(/usr/bin/gsutil ls)

/usr/bin/gcloud storage  cp  "$bucket"kaggle.json  /home/"$USER"/tmp
if [ ! $? -eq 0 ]; then
    printf "\nError Fatal: No existe el archivo kaggle.json en el bucket\n\n"
    printf "\nAbortando Instalacion\n\n"
    exit 1
fi


/usr/bin/gcloud storage  cp  "$bucket"estudiante_secretos.sh  /home/"$USER"/tmp
if [ ! $? -eq 0 ]; then
    printf "\nError Fatal: No existe el archivo estudiante_secretos.sh en el bucket\n\n"
    printf "\nAbortando Instalacion\n\n"
    exit 1
fi


cd /home/"$USER"/tmp/   || exit 1
find . -type f -size 0b -delete

if [ ! -e "kaggle.json" ]; then
    printf "\nError Fatal: No se pudo bajar el archivo kaggle.json\n\n"
    printf "\nAbortando Instalacion\n\n"
    exit 1
fi

if [ ! -e "estudiante_secretos.sh" ]; then
    printf "\nError Fatal: No se pudo bajar el archivo estudiante_secretos.sh\n\n"
    printf "\nAbortando Instalacion\n\n"
	exit 1
fi

#--------------------------------------
# Verificacion de los archivos

/home/"$USER"/machina/curso/secretos_verificar.sh
if [ ! $? -eq 0 ]; then
  exit 1
fi

/home/"$USER"/machina/curso/kaggle_verificar.sh
if [ ! $? -eq 0 ]; then
  exit 1
fi


#--------------------------------------
# Acciones

cd  /home/"$USER"  || exit 1

# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

# Acciones de kaggle.json -------------
# guardo el secreto de kaggle.json

bucket=$(/usr/bin/gsutil ls)
CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")

gcloud secrets describe kaggle-cred
if [ ! $? -eq 0 ]; then
  # creo de CERO el secreto
  gcloud secrets  create  kaggle-cred  --data-file=/home/"$USER"/.kaggle/kaggle.json
  if [ $? -eq 0 ]; then
    /usr/bin/gcloud storage rm  "$bucket"kaggle.json
  fi
else
  # actualizo el secreto
  gcloud secrets  versions add  kaggle-cred  --data-file=/home/"$USER"/.kaggle/kaggle.json
  if [ $? -eq 0 ]; then
    /usr/bin/gcloud storage rm  "$bucket"kaggle.json
  fi
fi


CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")
gcloud secrets add-iam-policy-binding kaggle-cred \
   --member="serviceAccount:$CURRENT_ACCOUNT" \
   --role="roles/secretmanager.secretAccessor"


# Acciones de estudiante_secretos.sh --------------
# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  "$vmach_bindir"/estudiante_secretos.sh

rm -rf  /home/"$USER"/tmp2
mkdir -p /home/"$USER"/tmp2

cd  /home/"$USER"/tmp2  || exit 1

git clone https://"$estudiante_github_usuario":"$estudiante_github_token"@github.com/"$estudiante_github_usuario"/"$vcur_github_catedra_repo".git
if [ ! $? -eq 0 ]; then
  echo "Error Fatal: no pude clonar  $estudiante_github_usuario / $vcur_github_catedra_repo"
  exit 1
fi

if [ ! -d  /home/"$USER"/tmp2/"$vcur_github_catedra_repo" ]; then
  echo "Error Fatal: No existe la carpeta del repo $vcur_github_catedra_repo"
  exit 1
fi

# ingreso a la carpeta del repo
cd  /home/"$USER"/tmp2/"$vcur_github_catedra_repo"  || exit 1
git config  user.email "$estudiante_github_email"
git config  user.name "$estudiante_github_nombre"
git remote  add  upstream  https://github.com/"$vcur_github_catedra_user"/"$vcur_github_catedra_repo"


# copio el repo clonado al Storage Bucket
/usr/bin/gcloud storage  cp  /home/"$USER"/tmp2/"$vcur_github_catedra_repo"   "$bucket""$vcur_github_catedra_repo"   --recursive

#---------------------------------------
cd /home/"$USER"  || exit 1


echo "Esperando 5 segundos"
sleep 5
printf "\n\nHa finalizado la segunda parte. Continua con asignar la clave.\n\n"
