#!/bin/bash
clear
cd
echo "+=============================================================================+"
echo "|                                Backup to NAS                                |"
echo "|                                  backup.sh                                  |"
echo "|                                    [60]                                     |"
echo "|                © 2020-2022 iDépanne – L'expert informatique                 |"
echo "|                            idepanne67@gmail.com                             |"
echo "+=============================================================================+"
echo ""
echo ""

########## Définition des variables ##########
varsys=$(cat /etc/os-release | grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)

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
	varitfc2="Graphique (GUI)"
else
	varitfc2="Lignes de commandes (CLI)"
fi
#############################################

echo -n "Système      :  "; echo "$varsys"
echo -n "Processeur   :  "; echo "$vararchi2"
echo -n "Interface    :  "; echo "$varitfc2"
echo ""
if [[ $varsys == *"MANJARO"* || $varsys == *"Manjaro"* ]]; then
	varman=$(hostnamectl --static)
	varusr=$(whoami)
	echo -n "Ordinateur   :  "; echo "$varman"
	echo -n "Utilisateur  :  "; echo "$varusr"
	echo ""
	echo "Source       :  /home/`echo "$varusr"`/"
	echo "Destination  :  NAS_PATH:/`echo "$varman"`/`echo "$varusr"`/"
	echo ""
    echo ""	
    echo "+-----------------------------------------------------------------------------+"
	echo "|                    **** Démarrage de la sauvegarde ****                     |"
	echo ""
    echo ""
	rclone sync -v -L -P --create-empty-src-dirs --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude=.config/pulse --exclude=.anydesk --exclude='VirtualBox VMs'/** --delete-excluded /home/`echo "$varusr"`/ NAS_PATH:/`echo "$varman"`/`echo "$varusr"`/
	echo ""
	echo "|                        **** Sauvegarde terminée ****                        |"
    echo "+-----------------------------------------------------------------------------+"

else

	vardeb=$(hostname)
	varusr=$(whoami)
	echo -n "Ordinateur   :  "; echo "$vardeb"
	echo -n "Utilisateur  :  "; echo "$varusr"
	echo ""
	echo "Source       :  /home/`echo "$varusr"`/"
	echo "Destination  :  NAS_PATH:/`echo "$vardeb"`/`echo "$varusr"`/"
	echo ""
    echo ""
    echo "+-----------------------------------------------------------------------------+"
	echo "|                    **** Démarrage de la sauvegarde ****                     |"
	echo ""
    echo ""
	rclone sync -v -L -P --create-empty-src-dirs --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude=.config/pulse --exclude=.anydesk --exclude='VirtualBox VMs'/** --delete-excluded /home/`echo "$varusr"`/ NAS_PATH:/`echo "$vardeb"`/`echo "$varusr"`/
	echo ""
	echo "|                        **** Sauvegarde terminée ****                        |"
    echo "+-----------------------------------------------------------------------------+"
fi
