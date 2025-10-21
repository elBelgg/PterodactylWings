# Dockerfile: alpine + wings + shell, arranca wings por defecto
FROM alpine:3.18

ARG WINGS_VERSION=latest
ARG WINGS_ARCH=linux_amd64

# Instala utilidades necesarias y compatibilidad glibc ligera
RUN apk add --no-cache \
    ca-certificates \
    curl \
    tar \
    bash \
    dumb-init \
    libc6-compat

# Descargar el binario de Wings (latest o versión concreta)
RUN if [ "$WINGS_VERSION" = "latest" ]; then \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/latest/download/wings_${WINGS_ARCH}"; \
    else \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/download/${WINGS_VERSION}/wings_${WINGS_ARCH}"; \
    fi \
  && curl -fsSL "$DOWNLOAD_URL" -o /usr/local/bin/wings \
  && chmod +x /usr/local/bin/wings

# Crear usuario no privilegiado y directorios esperados por wings
RUN adduser -D -h /home/wings -s /bin/bash wings \
  && mkdir -p /etc/pterodactyl /var/lib/wings /var/log/wings \
  && chown -R wings:wings /etc/pterodactyl /var/lib/wings /var/log/wings \
  && chmod 750 /etc/pterodactyl

WORKDIR /home/wings

# dumb-init como PID 1; por defecto ejecuta wings como usuario wings
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/wings"]

# Ejecuta wings sin argumentos por defecto, pero permite sobreescribir con 'docker run <image> <command>'
CMD []
USER wings

VOLUME ["/etc/pterodactyl", "/var/lib/wings", "/var/log/wings"]
