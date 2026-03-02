#build stage

# On s'appuie sur l'image ubuntu:noble
FROM ubuntu:noble AS builder

# Notre répertoire de travail

WORKDIR ./

# Installation de wget
RUN apt-get update \
	&& apt-get install -y wget \
	&& rm -rf /var/lib/apt/lists/*

# Utilisation de "wget" comme point d'entrée de notre conteneur
ENTRYPOINT ["/usr/bin/wget", "--"]


# Définition de la commande par défaut (exemple d'URL)
CMD ["https://github.com/OpenClassrooms-Student-Center/8431896-optimisez-votre-deploiement-en-creant-des-conteneurs-avec-docker/releases/tag/v0.0.3"]

LABEL Name="Libra" Version="0.0.1"
