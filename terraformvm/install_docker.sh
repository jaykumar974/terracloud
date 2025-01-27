#!/bin/bash
# Met à jour le système
sudo apt-get update -y
sudo apt-get upgrade -y

# Installe les dépendances nécessaires
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Ajoute la clé GPG officielle de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Ajoute le dépôt Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Installe Docker
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Ajoute l'utilisateur au groupe Docker
sudo usermod -aG docker azureadmin

# Active et démarre le service Docker
sudo systemctl enable docker
sudo systemctl start docker

# Installe Docker Compose
DOCKER_COMPOSE_VERSION="2.20.2"
sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Donne les permissions d'exécution
sudo chmod +x /usr/local/bin/docker-compose

# Vérifie l'installation
docker-compose --version

# Installe Git
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Clone le dépôt Git
git clone https://github.com/jaykumar974/terracloud.git 
cd /terracloud

# Construit les images Docker
docker compose build
docker compose up -d
sleep 30 # attendre 30 secondes que le container soit prêt
# faire les migrations
docker exec app php artisan migrate
docker exec app php artisan db:seed