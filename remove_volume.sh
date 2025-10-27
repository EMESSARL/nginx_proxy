#!/bin/bash

# Fonction pour afficher un message d'erreur et quitter le script
error_exit() {
    echo "Erreur : $1" 1>&2
    exit 1
}

# Suppression des conteneurs et des réseaux Docker
echo "Arrêt des services Docker..."
docker compose down || error_exit "Erreur lors de l'arrêt des services."

# Suppression des dossiers
DATA_DIR="./proxy_data/data"
LETSENCRYPT_DIR="./proxy_data/letsencrypt"
POSTGRES_DIR="./proxy_data/postgres"

if [ -d "$DATA_DIR" ]; then
    echo "Suppression du dossier $DATA_DIR..."
    rm -rf "$DATA_DIR" || error_exit "Impossible de supprimer le dossier $DATA_DIR."
fi

if [ -d "$LETSENCRYPT_DIR" ]; then
    echo "Suppression du dossier $LETSENCRYPT_DIR..."
    rm -rf "$LETSENCRYPT_DIR" || error_exit "Impossible de supprimer le dossier $LETSENCRYPT_DIR."
fi

if [ -d "$POSTGRES_DIR" ]; then
    echo "Suppression du dossier $POSTGRES_DIR..."
    rm -rf "$POSTGRES_DIR" || error_exit "Impossible de supprimer le dossier $POSTGRES_DIR."
fi

echo "Tous les services ont été arrêtés et les dossiers ont été supprimés avec succès."