FROM ghcr.io/pterodactyl/wings:latest

# Instala bash si no está incluido
RUN apk add --no-cache bash

# Establece bash como shell por defecto (opcional)
CMD ["/bin/bash"]
