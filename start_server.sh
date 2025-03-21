#!/bin/bash

# Vérifie si Docker et Docker Compose sont installés
if ! command -v docker &> /dev/null; then
    echo "Docker n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose n'est pas installé. Veuillez l'installer pour continuer."
    exit 1
fi
cd ./server
# Démarre le serveur avec Docker Compose en mode détaché
echo "Démarrage du serveur Flask en mode détaché..."

docker-compose up -d

cd ~
# Optionnel : Affiche les logs du conteneur
echo "Pour voir les logs, exécutez : docker-compose logs -f"