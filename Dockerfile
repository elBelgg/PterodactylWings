FROM ghcr.io/pterodactyl/wings:latest

# Actualiza e instala bash usando apt (Ubuntu/Debian base)
USER root
RUN apt-get update && apt-get install -y bash

# Establece bash como shell por defecto
CMD ["/bin/bash"]
