###
# Do not edit the generated Dockerfile
###

FROM "${BASE_IMAGE}"

RUN apt-get update && apt-get -y install --no-install-recommends ca-certificates="${CA_CERT_VERSION}" bzflag-server="${BZFS_VERSION}" && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --system bzfs

USER bzfs

ENTRYPOINT [ "/usr/games/bzfs" ]

CMD [ "--help" ]

### Runtime information and not relevant at build time

EXPOSE 5154/tcp

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Labmonkeys Space" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT"
