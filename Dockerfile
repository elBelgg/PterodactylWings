# Imagen base oficial
FROM ghcr.io/pterodactyl/wings:latest

# Usa Alpine para añadir utilidades
# (si la imagen base no tiene apk, copiamos binarios mínimos)
RUN echo "Installing shell..." && \
    mkdir -p /bin && \
    wget -qO /bin/busybox https://busybox.net/downloads/binaries/1.36.1-i686-uclibc/busybox && \
    chmod +x /bin/busybox && \
    /bin/busybox --install -s /bin

# Establece el entrypoint original
ENTRYPOINT ["/usr/bin/wings"]
