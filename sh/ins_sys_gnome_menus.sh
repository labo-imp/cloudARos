#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


logito="ins_sys_gnome_menus.txt"
fmach_salir_si_no_instalado  ins_sys_gnome.txt
fmach_salir_si_no_instalado  ins_sys_gnome_apps.txt



# reposync --------------------------------------
wget  $vcur_webfiles/github.png  \
      -O  "$vmach_bindir"/github.png


envsubst < /home/"$USER"/machina/cfg/reposync.desktop   >   "$vmach_bindir"/reposync.desktop

sudo  cp  "$vmach_bindir"/reposync.desktop    \
          /usr/share/applications/reposync.desktop


# repobrutalcopy ---------------------------------
wget  $vcur_webfiles/khabylame.png  \
      -O  "$vmach_bindir"/khabylame.png


envsubst < /home/"$USER"/machina/cfg/repobrutalcopy.desktop   >   "$vmach_bindir"/repobrutalcopy.desktop

sudo  cp  "$vmach_bindir"/repobrutalcopy.desktop    \
          /usr/share/applications/repobrutalcopy.desktop


# Establecer  Menu Dash -------------------------


dbus-run-session  gsettings set org.gnome.shell favorite-apps \
     "[ 'thunderbird.desktop', \
     'org.gnome.Nautilus.desktop', 'libreoffice-writer.desktop', \
     'yelp.desktop', 'firefox_firefox.desktop', 'google-chrome.desktop', \
     'brave-browser.desktop', 'org.gnome.Terminal.desktop', 'htop.desktop', \
     'jupyterlab.desktop', 'R.desktop', 'rstudio.desktop', \
     'code.desktop', 'reposync.desktop', 'repobrutalcopy.desktop' ]"


fmach_bitacora   "aplicaciones"
fmach_registrar_instalacion $logito