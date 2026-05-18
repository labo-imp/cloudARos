#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_rworld_first.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# instalar  R   version: 4.5.2 | released: 2025-10-31
# Documentacion  https://cran.r-project.org/

cd /home/"$USER" || exit 1
R_LIBS_USER=/home/"$USER"/.local/lib/R/site-library
mkdir  -p "$R_LIBS_USER"

cat > /home/"$USER"/.Renviron  <<FILE
R_LIBS_USER=$R_LIBS_USER
FILE


# update indices
sudo apt update -qq
# install two helper packages we need
# sudo apt install --no-install-recommends software-properties-common dirmngr
# add the signing key (by Michael Rutter) for these repos
# To verify key, run gpg --show-keys /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc 
# Fingerprint: E298A3A825C0D65DFD57CBB651716619E084DAB9
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the repo from CRAN -- lsb_release adjusts to 'noble' or 'jammy' or ... as needed
sudo add-apt-repository --yes -r "deb https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/"

sudo add-apt-repository --yes "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
sudo add-apt-repository --yes -r "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# install R itself
sudo apt update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes nala

sudo apt update -qq
sudo add-apt-repository --yes universe 
sudo apt update -qq

sudo DEBIAN_FRONTEND=noninteractive nala install --assume-yes  --no-install-recommends r-base-core  r-base-dev  r-cran-devtools

Rscript --verbose  /home/"$USER"/machina/r/test_rlang.r  "$vmach_logdir"/ins_rlang.txt

fmach_bitacora   "rlang"


#------------------------------------------------------------------------------
# r2u
echo "Package: *" | sudo tee /etc/apt/preferences.d/99cranapt
echo "Pin: release o=CRAN-Apt Project" | sudo tee -a /etc/apt/preferences.d/99cranapt
echo "Pin: release l=CRAN-Apt Packages" | sudo tee -a  /etc/apt/preferences.d/99cranapt
echo "Pin-Priority: 700" |  sudo tee -a /etc/apt/preferences.d/99cranapt

sudo apt update -qq

#------------------------------------------------------------------------------
# Instalo RStudio Server    Version: v2026.04.0+526 | Released: 2026-04-22 ----
# Doc  https://rstudio.com/products/rstudio/download-server/debian-ubuntu/

[ ! -e "$vmach_logdir/ins_rlang.txt" ] && exit 1

cd /home/"$USER" || exit 1

rstudiopack="rstudio-server-2026.04.0-526-amd64.deb"

wget  https://download2.rstudio.org/server/jammy/amd64/"$rstudiopack"


sudo  DEBIAN_FRONTEND=noninteractive  apt-get install --yes gdebi
sudo  DEBIAN_FRONTEND=noninteractive  gdebi -n "$rstudiopack"
rm  -f  "$rstudiopack"


# cambio el puerto del Rstudio Server al 80 para que se pueda acceder en aulas de universidades detras de firewalls
# Documentacion  https://support.rstudio.com/hc/en-us/articles/200552316-Configuring-the-Server
echo "www-port=80" | sudo tee -a /etc/rstudio/rserver.conf
echo "auth-timeout-minutes=0" | sudo tee -a /etc/rstudio/rserver.conf
echo "auth-stay-signed-in-days=30" | sudo tee -a /etc/rstudio/rserver.conf

echo "session-timeout-minutes=0" | sudo tee -a /etc/rstudio/rsession.conf 
sudo  rstudio-server restart

# rstudio-server status

systemctl is-active --quiet rstudio-server
if [ ! $? -eq 0 ]; then
    echo "servicio rstudio-server no esta funcionando"
else
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "$fecha" > "$vmach_logdir"/ins_rstudio.txt
fi

fmach_bitacora   "rstudio"

#------------------------------------------------------------------------------

# instalacion de  paquetes iniciales de R

[ ! -e "$vmach_logdir/ins_rlang.txt" ] && exit 1
[ ! -e "$vmach_logdir/ins_rstudio.txt" ] && exit 1

# Primera instalacion de paquetes de R , 5 minutos
# sudo DEBIAN_FRONTEND=noninteractive  apt-get --yes install \
#   r-cran-data.table  r-cran-rpart  r-cran-yaml \
#   r-cran-httr  r-cran-devtools  r-cran-yaml  r-cran-rlist \
#   r-cran-magrittr  r-cran-stringi  r-cran-curl  r-cran-openssl  \
#   r-cran-roxygen2  r-cran-ranger  r-cran-dplyr  r-cran-caret  \
#   r-cran-covr  r-cran-lintr  r-cran-tidyverse  \
#   r-cran-tidyr  r-cran-shiny r-cran-ggplot2  r-cran-plotly


# para utilizar  u2r  en  install.packages()
sudo Rscript -e 'install.packages("bspm","pak")'
sudo apt-get install python3-dbus python3-gi python3-apt
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_1.r  | sudo tee -a "$vmach_bindir"/log.txt


fmach_bitacora   "R  packages 1"
fmach_registrar_instalacion $logito