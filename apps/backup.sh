#!/bin/bash
clear
cd
echo "+=============================================================================+"
echo "|                                Backup to NAS                                |"
echo "|                                  backup.sh                                  |"
echo "|                                    [223]                                    |"
echo "|                © 2020-2022 iDépanne – L'expert informatique                 |"
echo "|                            idepanne67@gmail.com                             |"
echo "+=============================================================================+"
echo ""
echo ""

###### Définition des variables ######
var1=$(hostname)
var2=$(whoami)
######################################

echo "+=============================================================================+"
echo "|                    **** Démarrage de la sauvegarde ****                     |"
echo "+=============================================================================+"
echo ""
echo -n "Ordinateur   :  "; echo "$var1"
echo -n "Utilisateur  :  "; echo "$var2"
echo ""
echo "Source       :  /home/`echo "$var2"`/"
echo "Destination  :  NAS_PATH:/`echo "$var1"`/`echo "$var2"`/"
echo ""
rclone sync -v -L -P --ignore-errors --exclude=snap/** --exclude=.dbus/** --exclude='VirtualBox VMs'/** /home/`echo "$var2"`/ NAS_PATH:/`echo "$var1"`/`echo "$var2"`/
echo ""
echo "+=============================================================================+"
echo "|                        **** Sauvegarde terminée ****                        |"
echo "+=============================================================================+"
