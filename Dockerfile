# Etapa 1: construir los binarios necesarios
FROM alpine:latest AS builder

# Copiamos busybox y creamos el enlace simbólico para /bin/sh
RUN mkdir -p /out/bin \
    && cp /bin/busybox /out/bin/busybox \
    && ln -s busybox /out/bin/sh

# Etapa 2: imagen base de Wings
FROM ghcr.io/pterodactyl/wings:latest

# Copiamos los binarios preparados desde la etapa builder
COPY --from=builder /out/bin /bin

ENTRYPOINT ["/usr/bin/wings"]
