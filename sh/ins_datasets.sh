#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


logito="ins_datasets.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# copio vcur_pseudopublic  a list
cd  "$vmach_bindir" || exit 1
wget  --quiet --tries=3  $vcur_webfiles/$vcur_pseudopublic  -O  list
if [ ! $? -eq 0 ]; then
  rm -f list
else
  find ./list -type f -size 0b -delete
  chmod u+x  "$vmach_bindir"/list
fi



mkdir  -p  /home/"$USER"/datasets
mkdir  -p  /home/"$USER"/buckets/b1/datasets
mkdir  -p  /home/"$USER"/buckets/b1/exp
mkdir  -p  /home/"$USER"/buckets/b1/log

cd /home/"$USER"/datasets/ || exit 1
find . -type f -size 0b -delete

cd  /home/"$USER"/buckets/b1/datasets  || exit 1
find . -type f -size 0b -delete


if [ ! -e "$vcur_dataset1" ]; then
  wget --quiet --tries=3  "$vcur_webfiles"/"$vcur_dataset1"  -O  "$vcur_dataset1"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset1"
  fi
fi

if [ ! -e "$vcur_dataset2" ]; then
  wget --quiet --tries=3  "$vcur_webfiles"/"$vcur_dataset2"  -O  "$vcur_dataset2"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset2"
  fi
fi

if [ ! -e "$vcur_dataset3" ]; then
  wget --quiet  --tries=3  "$vcur_webfiles"/"$vcur_dataset3"  -O  "$vcur_dataset3"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset3"
  fi
fi

if [ ! -e "$vcur_dataset4" ]; then
  wget --quiet --tries=3  "$vcur_webfiles"/"$vcur_dataset4"  -O  "$vcur_dataset4"
  if [ ! $? -eq 0 ]; then
    rm  -f  "$vcur_dataset4"
  fi
fi


cp /home/"$USER"/buckets/b1/datasets/*   /home/"$USER"/datasets


cd


fmach_bitacora   "datasets"
fmach_registrar_instalacion $logito