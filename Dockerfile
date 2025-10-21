# Stage único: imagen basada en Ubuntu que contiene wings y bash
FROM ubuntu:22.04

ARG WINGS_VERSION=latest
ARG WINGS_ARCH=linux_amd64

# Instala utilidades necesarias
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    jq \
    dumb-init \
    bash \
  && rm -rf /var/lib/apt/lists/*

# Descarga el binario de Wings (latest o versión concreta)
RUN if [ "$WINGS_VERSION" = "latest" ]; then \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/latest/download/wings_${WINGS_ARCH}"; \
    else \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/download/${WINGS_VERSION}/wings_${WINGS_ARCH}"; \
    fi \
  && curl -fsSL "$DOWNLOAD_URL" -o /usr/local/bin/wings \
  && chmod +x /usr/local/bin/wings

# Crear usuario no privilegiado y directorios esperados por wings
RUN useradd -m -d /home/wings -s /bin/bash wings || true \
  && mkdir -p /etc/pterodactyl /var/lib/wings /var/log/wings \
  && chown -R wings:wings /etc/pterodactyl /var/lib/wings /var/log/wings

WORKDIR /home/wings
USER wings

VOLUME ["/etc/pterodactyl", "/var/lib/wings", "/var/log/wings"]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash"]
