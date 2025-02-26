#!/bin/bash

DATE=$(date +"%Y_%m_%d_%H_%M_%S")
CARPETAS=("/var/lib/etcd" "/etc/kubernetes" "/home/asix/odoo-kubernetes")
DESTINACIO="$DATE_Yassir_backupCluster.tar.gz"

# Comprimir amb tar
sudo tar -czv $DESTINATION_NAME ${SOURCES[@]}
