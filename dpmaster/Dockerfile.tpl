###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BUILDER_BASE_IMAGE}" as builder

USER root

WORKDIR /root

RUN apk --no-cache add curl g++ gcc make git && \
    git clone https://github.com/labmonkeys-space/dpmaster && \
    cd dpmaster/src && make release

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

RUN adduser --system dpmaster

COPY --chown=dpmaster --from=builder /root/dpmaster/src/dpmaster /usr/local/bin

USER dpmaster

ENTRYPOINT [ "/usr/local/bin/dpmaster" ]

CMD [ "--help" ]

### Runtime information and not relevant at build time

EXPOSE 27950/udp

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Labmonkeys Space" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT"
