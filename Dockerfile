FROM pterodactyl/wings:latest

# Instala bash si no está disponible
RUN apk add --no-cache bash

# Establece bash como shell por defecto (opcional)
CMD ["/bin/bash"]
