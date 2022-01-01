#!/bin/bash
cd
echo "###############################################################################"
echo "#                                                                             #"
echo "#                             Backup to NAS 2.1.1                             #"
echo "#                   © 2021 iDépanne – L'expert informatique                   #"
echo "#                           https://fb.me/idepanne/                           #"
echo "#                            idepanne67@gmail.com                             #"
echo "#                                                                             #"
echo "###############################################################################"
echo ""
echo ""
echo "==============================================================================="
echo "   • Sauvegarde en cours..."
echo "==============================================================================="
echo ""
var1=$(hostname)
var2=$(whoami)
echo -n "Nom d'hôte   :  "; echo "$var1"
echo -n "Utilisateur  :  "; echo "$var2"
echo ""
echo "Source       :  /home/`echo "$var2"`/"
echo "Destination  :  NAS_PATH:/`echo "$var1"`/`echo "$var2"`/"
echo ""
rclone sync -v -L -P --ignore-errors --exclude=snap/** --exclude='VirtualBox VMs'/** /home/`echo "$var2"`/ NAS_PATH:/`echo "$var1"`/`echo "$var2"`/
echo ""
echo ""
echo "###############################################################################"
echo "#                                                                             #"
echo "#                             Sauvegarde terminée                             #"
echo "#                                                                             #"
echo "###############################################################################"
