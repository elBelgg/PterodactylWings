FROM alpine:3.18

# Instalar dependencias mínimas
RUN apk add --no-cache curl bash ca-certificates

# Descargar Wings (ajusta la versión)
RUN curl -L -o /usr/bin/wings https://github.com/pterodactyl/wings/releases/download/v1.11.13/wings-linux-amd64 \
    && chmod +x /usr/bin/wings

# Entrypoint original
ENTRYPOINT ["/usr/bin/wings"]
