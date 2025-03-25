#!/bin/bash

# Fonction pour afficher un message d'erreur et quitter le script
error_exit() {
    echo "Erreur : $1" 1>&2
    exit 1
}

# Vérification et création des dossiers nécessaires
DATA_DIR="./data"
LETSENCRYPT_DIR="./letsencrypt"
POSTGRES_DIR="./postgres"

if [ ! -d "$DATA_DIR" ]; then
    echo "Création du dossier $DATA_DIR..."
    mkdir -p "$DATA_DIR" || error_exit "Impossible de créer le dossier $DATA_DIR."
fi

if [ ! -d "$LETSENCRYPT_DIR" ]; then
    echo "Création du dossier $LETSENCRYPT_DIR..."
    mkdir -p "$LETSENCRYPT_DIR" || error_exit "Impossible de créer le dossier $LETSENCRYPT_DIR."
fi

if [ ! -d "$POSTGRES_DIR" ]; then
    echo "Création du dossier $POSTGRES_DIR..."
    mkdir -p "$POSTGRES_DIR" || error_exit "Impossible de créer le dossier $POSTGRES_DIR."
fi

# Vérification de l'installation de Certbot
if command -v certbot > /dev/null; then
    echo "Certbot est déjà installé."
else
    echo "Certbot n'est pas installé. Installation en cours..."

    # Mise à jour des paquets
    sudo apt update || error_exit "Échec de la mise à jour des paquets."

    # Installation de Certbot
    sudo apt install -y certbot || error_exit "Échec de l'installation de Certbot."
    
    echo "Certbot a été installé avec succès."
fi

# Suppression des conteneurs existants
echo "Suppression des conteneurs existants..."
docker-compose down || error_exit "Erreur lors de la suppression des conteneurs."

# Lancement du service Docker
echo "Lancement du service Nginx Proxy Manager et PostgreSQL..."
docker-compose up -d || error_exit "Erreur lors du lancement du service."

echo "Service Nginx Proxy Manager et PostgreSQL lancé avec succès."