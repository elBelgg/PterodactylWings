# Etapa 1: obtener BusyBox desde Alpine
FROM alpine:latest AS builder

# Copiamos el binario real de busybox desde Alpine
RUN cp /bin/busybox /tmp/busybox

# Etapa 2: Imagen base de Wings
FROM ghcr.io/pterodactyl/wings:latest

# Copiamos el binario busybox desde la etapa anterior
COPY --from=builder /tmp/busybox /bin/busybox

# Creamos un enlace simbólico manual para "sh"
# (sin usar RUN porque esta imagen no tiene shell)
# Esto usa la instrucción Docker ADD para duplicar el archivo con otro nombre
ADD --chown=0:0 busybox /bin/sh

ENTRYPOINT ["/usr/bin/wings"]
