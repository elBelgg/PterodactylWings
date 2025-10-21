# Usa una imagen base con shell y gestor de paquetes
FROM ubuntu:22.04

ARG WINGS_VERSION=latest
ARG WINGS_ARCH=linux_amd64

# Instala utilidades y crea usuario
RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  tar \
  jq \
  dumb-init \
  bash \
  && rm -rf /var/lib/apt/lists/*

# Descarga el binario de Wings desde las releases de GitHub y lo instala
# Nota: el nombre del artefacto puede variar según versión/arquitectura.
# Si tu despliegue necesita otra URL o nombre de archivo, ajusta la línea de descarga.
RUN if [ "$WINGS_VERSION" = "latest" ]; then \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/latest/download/wings_${WINGS_ARCH}"; \
    else \
      DOWNLOAD_URL="https://github.com/pterodactyl/wings/releases/download/${WINGS_VERSION}/wings_${WINGS_ARCH}"; \
    fi \
  && curl -fsSL "$DOWNLOAD_URL" -o /usr/local/bin/wings \
  && chmod +x /usr/local/bin/wings

# Crea usuario no privilegiado (coincide con prácticas de Wings)
RUN useradd -m -d /home/wings -s /bin/bash wings || true \
  && mkdir -p /etc/pterodactyl /var/lib/wings /var/log/wings \
  && chown -R wings:wings /etc/pterodactyl /var/lib/wings /var/log/wings

# Cambia a usuario no root por defecto
USER wings
WORKDIR /home/wings

# Exponer punto de montaje/configuración a través de volúmenes (opcional)
VOLUME ["/etc/pterodactyl", "/var/lib/wings", "/var/log/wings"]

# Usa dumb-init para manejo de PID 1; por defecto arranca un shell interactivo
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/bin/bash"]
