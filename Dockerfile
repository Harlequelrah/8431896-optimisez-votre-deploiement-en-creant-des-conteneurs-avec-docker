# On s'appuie sur l'image ubuntu:noble
FROM ubuntu:noble AS builder

# On rend paramétrable la version de l'application Libra à télécharger

ARG LIBRA_VERSION=0.0.1

ARG LIBRA_CHECKSUM=d0757c5b427825126f98ffa07683d676fb8c62a02d098659cce9d3cd485b79a0

ARG LIBRA_REPOSITORY=https://github.com/Bornholm/libra

# On mets à jour les dépendances

RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y


# On installe les dépendance nécessaires à la récupération de l’application Libra
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y wget

# On télécharge l'archive contenant l'exécutable Libra

RUN wget \
    -O libra.tar.gz \
    ${LIBRA_REPOSITORY}/releases/download/v${LIBRA_VERSION}/libra_${LIBRA_VERSION}_linux_amd64.tar.gz



# On vérifie l'empreinte de l'archive
RUN echo "${LIBRA_CHECKSUM} libra.tar.gz" | sha256sum --check --status

# On créait le répertoire /usr/local/bin
RUN mkdir -p /usr/local/bin

# On extrait le binaire Libra contenu dans l'archive et on le place directement dans le répertoire /usr/local/bin

RUN tar -xzf libra.tar.gz -C /usr/local/bin libra

# On s'assure que le binaire est éxécutable
RUN chmod +x /usr/local/bin/libra

# On indique que l'application écoute sur le port 8080 et qu'il devrait être exposé
EXPOSE 8080


# On indique que le conteneur souhaite utliser un volume pour le répertoire /uploads
VOLUME /uploads


# On configure l'exécutable comme processus à lancer au démarrage du conteneur

CMD ["/user/local/bin/libra"]

# Description
LABEL Name="Libra" Version="0.0.1"
