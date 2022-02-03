#!/bin/bash
clear
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                             Backup to NAS 2.2.1                             #"
echo "#                                  backup.sh                                  #"
echo "#                 © 2021-2022 iDépanne – L'expert informatique                #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
var1=$(hostname)
var2=$(whoami)
echo "==============================================================================="
echo "                     **** Démarrage de la sauvegarde ****                      "
echo "==============================================================================="
echo ""
echo -n "Ordinateur   :  "; echo "$var1"
echo -n "Utilisateur  :  "; echo "$var2"
echo ""
echo "Source       :  /home/`echo "$var2"`/"
echo "Destination  :  NAS_PATH:/`echo "$var1"`/`echo "$var2"`/"
echo ""
rclone sync -v -L -P --ignore-errors --exclude=snap/** --exclude='VirtualBox VMs'/** /home/`echo "$var2"`/ NAS_PATH:/`echo "$var1"`/`echo "$var2"`/
echo ""
echo "==============================================================================="
echo "                         **** Sauvegarde terminée ****                         "
echo "==============================================================================="
