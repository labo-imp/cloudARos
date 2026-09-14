#!/bin/bash
# fecha revision   2026-09-14  17:47

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_system.txt"
# idempotent, run again if neccesary
fmach_salir_si_no_instalado  ins_sys_architecture.txt
fmach_salir_si_no_instalado  ins_sec_estudiante_secretos.txt


sudo  DEBIAN_FRONTEND=noninteractive  apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install --yes nala

# librerias necesarias para R, Python, Julia, JupyterLab, son mas de 700

sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      cmake  gdebi  curl  sshpass  nano    \
      htop  atop  iotop  iputils-ping      \
      cron  tmux  git-core  zip  unzip     \
      sysstat  smbclient cifs-utils  rsync \
      libopenmpi-dev  openssh-server sshfs \
      shellcheck  rustc  cargo             \
      libssl-dev  apt-utils                


sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      libcurl4-openssl-dev  libxml2-dev    \
      libgeos-dev  libproj-dev             \
      libgdal-dev  librsvg2-dev             

sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      ocl-icd-opencl-dev  libmagick++-dev  \
      libv8-dev  libsodium-dev             \
      libharfbuzz-dev  libfribidi-dev      \
      pandoc texlive  texlive-xetex        \
      texlive-fonts-recommended            \
      texlive-latex-recommended            \
      libudunits2-dev  inotify-tools

sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      libssh2-1-dev  libgit2-dev           \
      ffmpeg  gir1.2-gtop-2.0 lm-sensors   \
      debconf-utils  swig  libopenblas-dev \
      libhiredis-dev  gdal-bin             \
      libglu1-mesa-dev  libgmp3-dev        \
      libgsl0-dev  jags  libmpfr-dev       \
      libzmq3-dev libglpk-dev  default-jdk 


sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      libdbus-glib-1-dev libdbus-1-dev


sudo  DEBIAN_FRONTEND=noninteractive  nala install --assume-yes \
      build-essential  pkg-config  libssl-dev

fmach_bitacora   "sys system packages"
fmach_registrar_instalacion $logito