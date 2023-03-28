#!/bin/bash
clear
cd || return
echo "+=============================================================================+"
echo "|                                Backup to NAS                                |"
echo "|                                  backup.sh                                  |"
echo "|                                    [100]                                    |"
echo "|                © 2020-2023 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""

########## Définition des variables ##########
varsys=$(< /etc/os-release grep PRETTY_NAME)
if [[ $varsys == *"EndeavourOS"* ]]; then
	varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c13-)
else
	varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
fi

vararchi1=$(uname -m)
if [[ $vararchi1 == *"aarch"* ]]; then
	if [[ $vararchi1 == *"aarch64"* ]]; then
		vararchi2="ARM (64 bits)"
	else
		vararchi2="ARM (32 bits)"
	fi
else
	if [[ $vararchi1 == *"x86_64"* ]]; then
		vararchi2="x86 (64 bits)"
	else
		vararchi2="x86 (32 bits)"
	fi
fi

varitfc1=$(ls /usr/bin/*session)
if [[ $varitfc1 == *"lxsession"* || $varitfc1 == *"openbox"* || $varitfc1 == *"pipewire-media"* || $varitfc1 == *"xfce"* || $varitfc1 == *"gnome"* || $varitfc1 == *"kde"* || $varitfc1 == *"cinnamon"* || $varitfc1 == *"mate"* ]]; then
	varitfc2="Graphique"
else
	varitfc2="Lignes de commandes"
fi

ip=$(< ~/.config/rclone/rclone.conf grep host | cut -c8-)
dest=$(< ~/.config/rclone/rclone.conf grep remote | cut -c20-)
#############################################

echo -n "Système      :  "; echo "$varsys"
echo -n "Processeur   :  "; echo "$vararchi2"
echo -n "Interface    :  "; echo "$varitfc2"
echo ""
varcmp=$(uname -n)
varusr=$(whoami)
echo -n "Ordinateur   :  "; echo "$varcmp"
echo -n "Utilisateur  :  "; echo "$varusr"
echo ""
echo "Source       :  /home/$varusr/"
echo "Destination  :  /$ip/$dest/$varcmp/$varusr/"
echo ""
echo ""
echo ""
echo "****************************** /!\ IMPORTANT /!\ ******************************"
echo "*                                                                             *"
echo "*        Fermez toutes vos applications avant de faire une sauvegarde,        *"
echo "*       les fichiers en cours d'utilisation ne peuvent pas être copiés.       *"
echo "*                                                                             *"
echo "*             Pressez Ctrl+C pour annuler la sauvegarde en cours.             *"
echo "*                                                                             *"
echo "*******************************************************************************"
sleep 3
echo ""
echo ""
echo ""
echo "+-----------------------------------------------------------------------------+"
echo "|                   ***** Démarrage de la sauvegarde *****                    |"
echo ""
echo ""
rclone sync -v -L -P --create-empty-src-dirs --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude=.cloud-ipc-socket --exclude=.cache/** --exclude=.config/pulse/** --exclude=.config/discord/** --exclude=.config/molotov/** --exclude=.config/skypeforlinux/** --exclude=.anydesk/** --exclude='VirtualBox VMs'/** --exclude=Qemu/** --exclude=.zoom/** --exclude=.local/share/Steam/** --exclude=.steam/** --exclude=.local/share/'Euro Truck Simulator 2'/** --exclude=.var/app/com.valvesoftware.Steam/** --exclude=.var/app/com.valvesoftware.Steam/.steampath --exclude=.steampath --exclude=.steampid --delete-excluded /home/"$varusr"/ NAS_PATH:/"$varcmp"/"$varusr"/
echo ""
echo "|                       ***** Sauvegarde terminée *****                       |"
echo "+-----------------------------------------------------------------------------+"
