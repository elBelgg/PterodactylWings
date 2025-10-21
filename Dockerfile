# Etapa 1: obtener busybox desde Alpine
FROM alpine:latest AS builder
RUN cp /bin/busybox /busybox

# Etapa 2: imagen de Wings con shell
FROM ghcr.io/pterodactyl/wings:latest
COPY --from=builder /busybox /bin/busybox
RUN chmod +x /bin/busybox && /bin/busybox --install -s /bin

ENTRYPOINT ["/usr/bin/wings"]
