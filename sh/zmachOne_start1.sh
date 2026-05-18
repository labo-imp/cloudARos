#!/bin/bash
# fecha revision   2026-05-18  12:02

# corre en  instance-instalacion, llamado desde Cloud Shell
# instance-instalacion esta recien creada, completamente virgen

vmach_github_user="$1"
vmach_github_repo="$2"
cursoarch="$3"
# bug en Ubuntu 26.04
sudo update-alternatives --set sudo /usr/bin/sudo.ws


# Usuario  ds

# creacion usuario ds
sudo  useradd  -m -s /bin/bash  ds

# password de ds
CLAVE=$(/snap/bin/gcloud secrets versions access latest --secret="ds-password")
echo  "ds:$CLAVE" | sudo  /usr/sbin/chpasswd

# permisos de sudo a nuevo usuario ds
sudo usermod -aG sudo ds
sudo usermod -aG google-sudoers ds

# Create a dedicated file for the user in sudoers.d
echo "ds ALL=(ALL:ALL) ALL" | sudo tee /etc/sudoers.d/ds
# Set required permissions (read-only for owner and group)
sudo chmod 0440 /etc/sudoers.d/ds


# log in  con usuario ds
export vmach_github_user
export vmach_github_repo
export cursoarch
sudo --preserve-env=vmach_github_user,vmach_github_repo,cursoarch   su ds

sleep 5
cd /home/"$USER" || exit 1


sudo  DEBIAN_FRONTEND=noninteractive  apt-get update


sudo  apt-get --yes  install  git rsync htop


# clono el repo de instalacion
rm -rf /home/"$USER"/machina
cd /home/"$USER" || exit 1
git clone  https://github.com/"$vmach_github_user"/"$vmach_github_repo".git   machina

# permisos de ejecucion
chmod u+x  /home/"$USER"/machina/curso/*.sh
chmod u+x  /home/"$USER"/machina/sh/*.sh
chmod u+x  /home/"$USER"/machina/jl/*.jl
chmod u+x  /home/"$USER"/machina/direct/*.sh


source  /home/"$USER"/machina/sh/common_machina.sh

MY_PROJECT_ID=$(gcloud projects list --filter="projectId~$vmach_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"
CURRENT_ACCOUNT=$(gcloud iam service-accounts list  --format="value(email)")

# personalizacion del curso
echo personalizacion
if [ ! -e /home/"$USER"/.curso ]; then
  gcloud secrets describe  ds-curso
  if [ $? -eq 0 ]; then
    cursoarch=$(gcloud secrets versions access latest --secret="ds-curso")
    echo "$cursoarch"
    if [  -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
      echo  "$cursoarch"  >  /home/"$USER"/.curso
    fi
  fi
fi


if [ -e /home/"$USER"/.curso ]; then
  cursoarch=$(cat /home/"$USER"/.curso)
  if [  -f /home/"$USER"/machina/curso/"$cursoarch" ]; then
    cp  /home/"$USER"/machina/curso/"$cursoarch"  /home/"$USER"/machina/curso/common_curso.sh
  fi
fi


source  /home/"$USER"/machina/sh/common_machina.sh

rm -rf  "$vmach_bindir"
mkdir  -p  "$vmach_bindir"
mkdir  -p  "$vmach_logdir"


# despersonalizacion
cp /home/"$USER"/machina/sh/common_machina.sh  "$vmach_bindir"/common.sh
cat /home/"$USER"/machina/curso/common_curso.sh  >>  "$vmach_bindir"/common.sh


# copia de direct
cp /home/"$USER"/machina/direct/*   "$vmach_bindir"/


# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
fmach_bitacora   "START  instalar.sh"

# tmux vim
/home/"$USER"/machina/sh/ins_tool_vimtmux.sh

