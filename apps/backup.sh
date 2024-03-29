#!/bin/bash
cd || return
echo "+=============================================================================+"
echo "|                                Backup to NAS                                |"
echo "|                                  backup.sh                                  |"
echo "|                                    [137]                                    |"
echo "|                © 2019-2024 iDépanne – L'expert informatique                 |"
echo "|                        idepanne.support.tech@free.fr                        |"
echo "+=============================================================================+"
echo ""
echo ""

########## Définition des variables ##########
varsys=$(< /etc/os-release grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)

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

ip=$(< ~/.config/rclone/rclone.conf grep host | cut -c8-)
dest=$(< ~/.config/rclone/rclone.conf grep remote | cut -c20-)
#############################################

echo -n "Système      :  "; echo "$varsys"
echo -n "Processeur   :  "; echo "$vararchi2"
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
echo "Connexion au serveur NAS..."
echo ""
if ping -c 3 $ip; then
    echo ""
    echo ""
	echo "[O] Connexion établie"
    echo ""
    echo "+-----------------------------------------------------------------------------+"
    echo "|                   ***** Démarrage de la sauvegarde *****                    |"
    echo ""
    echo ""
    rclone sync -v -L -P --create-empty-src-dirs --ignore-errors --exclude=**/.** --exclude=/.** --exclude=snap/** --exclude=pulse/** --exclude=discord/** --exclude=molotov/** --exclude=skypeforlinux/** --exclude='VirtualBox VMs'/** --exclude=Qemu/** --exclude=Steam/** --exclude='Euro Truck Simulator 2'/** --exclude=com.valvesoftware.Steam/** --exclude=parcellite/** --delete-excluded /home/"$varusr"/ NAS_PATH:/"$varcmp"/"$varusr"/
    echo ""
    echo "|                       ***** Sauvegarde terminée *****                       |"
    echo "+-----------------------------------------------------------------------------+"
    echo ""
    echo "[V] Déconnexion"
else
    echo ""
	echo "[X] Serveur NAS introuvable !"
    echo ""
    echo "+-----------------------------------------------------------------------------+"
    echo "|                     ***** Echec de la sauvegarde *****                      |"
    echo "+-----------------------------------------------------------------------------+"
fi
