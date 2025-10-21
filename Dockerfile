# Etapa 1: obtener busybox desde Alpine
FROM alpine:latest AS builder
RUN cp /bin/busybox /busybox

# Etapa 2: imagen final basada en Wings
FROM ghcr.io/pterodactyl/wings:latest

# Copiar busybox preinstalado
COPY --from=builder /busybox /bin/busybox

# Crear enlaces simbólicos manualmente (sin ejecutar comandos)
# BusyBox permite que sh se ejecute directamente usando su nombre
# Así que solo hacemos un enlace básico para tener "sh"
ADD ["busybox", "/bin/sh"]

ENTRYPOINT ["/usr/bin/wings"]
