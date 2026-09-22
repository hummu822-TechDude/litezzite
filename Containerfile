# Base image built for light performance on older hardware (XFCE Desktop)
FROM ghcr.io/ublue-os/xfce-main:latest

LABEL org.opencontainers.image.title="Litezzite" \
      org.opencontainers.image.description="Ultra-lightweight Linux spin for older hardware"

# Remove heavy background tools and extra bloat
RUN rpm-ostree override remove \
    firefox \
    firefox-langpacks \
    pidgin \
    hexchat \
    && rpm-ostree cleanup -a

# Disable heavy background services to save CPU & RAM cycles
RUN systemctl disable NetworkManager-wait-online.service \
    && systemctl disable cups.service

# Remove localized manual files to shrink system footprint
RUN rm -rf /usr/share/doc/* \
    && rm -rf /usr/share/man/*

# Save image layer state
RUN ostree container commit
