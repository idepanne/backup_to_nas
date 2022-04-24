#!/bin/bash
clear
cd
echo "+=============================================================================+"
echo "|                                Backup to NAS                                |"
echo "|                                  backup.sh                                  |"
echo "|                                    [28]                                     |"
echo "|                © 2020-2022 iDépanne – L'expert informatique                 |"
echo "|                            idepanne67@gmail.com                             |"
echo "+=============================================================================+"
echo ""
echo ""
echo ""
varsys=$(cat /etc/os-release | grep PRETTY_NAME | cut -c14- | rev | cut -c2- | rev)
echo -n "Système      : "; echo "$varsys"
echo ""
echo ""
echo ""
if [[ $varsys == *"Manjaro"* ]]; then
	varman=$(hostnamectl --static)
	varusr=$(whoami)
	echo "+=============================================================================+"
	echo "|                    **** Démarrage de la sauvegarde ****                     |"
	echo "+=============================================================================+"
	echo ""
	echo -n "Ordinateur   :  "; echo "$varman"
	echo -n "Utilisateur  :  "; echo "$varusr"
	echo ""
	echo "Source       :  /home/`echo "$varusr"`/"
	echo "Destination  :  NAS_PATH:/`echo "$varman"`/`echo "$varusr"`/"
	echo ""
	rclone sync -v -L -P --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude=.config/pulse --exclude=.anydesk --exclude='VirtualBox VMs'/** /home/`echo "$varusr"`/ NAS_PATH:/`echo "$varman"`/`echo "$varusr"`/
	echo ""
	echo "+=============================================================================+"
	echo "|                        **** Sauvegarde terminée ****                        |"
	echo "+=============================================================================+"

else

	vardeb=$(hostname)
	varusr=$(whoami)
	echo "+=============================================================================+"
	echo "|                    **** Démarrage de la sauvegarde ****                     |"
	echo "+=============================================================================+"
	echo ""
	echo -n "Ordinateur   :  "; echo "$vardeb"
	echo -n "Utilisateur  :  "; echo "$varusr"
	echo ""
	echo "Source       :  /home/`echo "$varusr"`/"
	echo "Destination  :  NAS_PATH:/`echo "$vardeb"`/`echo "$varusr"`/"
	echo ""
	rclone sync -v -L -P --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude=.config/pulse --exclude=.anydesk --exclude='VirtualBox VMs'/** /home/`echo "$varusr"`/ NAS_PATH:/`echo "$vardeb"`/`echo "$varusr"`/
	echo ""
	echo "+=============================================================================+"
	echo "|                        **** Sauvegarde terminée ****                        |"
	echo "+=============================================================================+"
fi
