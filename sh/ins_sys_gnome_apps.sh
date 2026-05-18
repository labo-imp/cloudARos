#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_sys_gnome_apps.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_ya_instalado $logito  ins_sys_gnome.txt


# LibreOffice
sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes install libreoffice

# Google Chrome
cd /home/"$USER" || exit 1
wget  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo DEBIAN_FRONTEND=noninteractive  dpkg -i google-chrome-stable_current_amd64.deb
rm  -f  ./google-chrome-stable_current_amd64.deb
sudo  DEBIAN_FRONTEND=noninteractive  apt --yes  modernize-sources

# Brave Browser
sudo  curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo  "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get install --yes brave-browser
sudo  DEBIAN_FRONTEND=noninteractive  apt --yes  modernize-sources


# RStudio desktop (atencion que NO es el servidor)
cd /home/"$USER" || exit 1
sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
rstudiodesktop="rstudio-2026.04.0-526-amd64.deb"
wget  https://download1.rstudio.org/electron/jammy/amd64/$rstudiodesktop
sudo  DEBIAN_FRONTEND=noninteractive  apt-get install  --yes -f ./$rstudiodesktop
rm  -f  $rstudiodesktop

# bug RStudio desktop que se cuelga al arrancar
sudo chmod 4755 /usr/lib/rstudio/chrome-sandbox

# instalar VSCode -------------------------------------------------------------
sudo  DEBIAN_FRONTEND=noninteractive  apt-get update
sudo  apt-get install software-properties-common apt-transport-https wget -y
sudo snap install --classic code
sudo cp  /snap/code/current/snap/gui/code.desktop  /usr/share/applications/code.desktop

#wget  -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
#sudo  add-apt-repository --yes "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#sudo  DEBIAN_FRONTEND=noninteractive  apt-get install --yes code


# instalo extensiones de VSCode
code  --install-extension  ms-python.python
code  --install-extension  ms-python.vscode-pylance

code  --install-extension  KevinRose.vsc-python-indent

code  --install-extension  ms-toolsai.jupyter
code  --install-extension  ms-toolsai.jupyter-keymap
code  --install-extension  ms-toolsai.jupyter-renderers

code  --install-extension  eamodio.gitlens
code  --install-extension  GitHub.copilot
code  --install-extension  GitHub.copilot-chat

code  --install-extension  REditorSupport.r
code  --install-extension  RDebugger.r-debugger

code  --install-extension  julialang.language-julia

code  --install-extension  usernamehw.todo-md

fmach_bitacora   "sys_gnome_apps"
#------------------------------------------------------------------------------
# gnome extension  Vitals, show  only  Memory and CPU usage on bar

mkdir -p /home/"$USER"/.local/share/gnome-shell/extensions
git clone https://github.com/corecoding/Vitals.git   /home/"$USER"/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com  -b  develop

# Se exporta con: dconf dump /

# hardcodeo la configuracion para mostrar solo  memoria y CPU
cp  /home/"$USER"/machina/cfg/desktop.dconf  /home/"$USER"/.config/dconf/desktop.dconf

/usr/bin/gnome-extensions  enable  Vitals@CoreCoding.com

/usr/bin/gnome-extensions  disable Vitals@CoreCoding.com
/usr/bin/gnome-extensions  enable Vitals@CoreCoding.com


rm -rf  /home/"$USER"/.local/share/gnome-shell/extensions/executor@raujonas.github.io
wget  https://github.com/raujonas/executor/archive/refs/tags/v28.zip  -O  "$vmach_bindir"/executor-28.zip
gnome-extensions install  "$vmach_bindir"/executor-28.zip
/usr/bin/gnome-extensions  enable  executor@raujonas.github.io


cd  /home/"$USER"/.config/dconf/   || exit 1
dconf load / <  desktop.dconf
cd /home/"$USER" || exit 1

#------------------------------------------------------------------------------
# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh


wget  $vcur_webfiles/khabylame.png  \
      -O  "$vmach_bindir"/khabylame.png
      
envsubst < /home/"$USER"/machina/direct/repobrutalcopy.desktop   >   "$vmach_bindir"/repobrutalcopy.desktop
sudo  cp  "$vmach_bindir"/repobrutalcopy.desktop    \
          /usr/share/applications/repobrutalcopy.desktop

envsubst < /home/"$USER"/machina/direct/reposync.desktop   >   "$vmach_bindir"/reposync.desktop
sudo  cp  "$vmach_bindir"/reposync.desktop    \
          /usr/share/applications/reposync.desktop


fmach_registrar_instalacion $logito