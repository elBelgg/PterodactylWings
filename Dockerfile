FROM ghcr.io/pterodactyl/wings:latest

# Copiar BusyBox para tener un shell (sh) y utilidades básicas
ADD https://busybox.net/downloads/binaries/1.36.1-x86_64-linux-musl/busybox /bin/busybox

RUN chmod +x /bin/busybox && \
    /bin/busybox --install -s /bin

ENTRYPOINT ["/usr/bin/wings"]
