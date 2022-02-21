###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BUILDER_BASE_IMAGE}" as builder

WORKDIR /root

# hadolint ignore=DL3018, DL3003
RUN apk --no-cache add curl g++ gcc make git sdl2-dev && \
    git clone https://github.com/ioquake/ioq3.git && \
    cd ioq3 && git checkout ${GIT_COMMIT} && make release

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

RUN adduser --system ioq3

COPY --chown=ioq3 --from=builder /root/ioq3/build/release-linux-x86_64 /opt/ioq3

USER ioq3

ENTRYPOINT [ "/opt/ioq3/ioq3ded.x86_64" ]

CMD [ "-v" ]

### Runtime information and not relevant at build time

VOLUME [ "/opt/ioq3/baseq3" ]

EXPOSE 27960/udp

LABEL org.opencontainers.image.created="${DATE}" \
      org.opencontainers.image.description="The ioquake3 community effort to continue supporting/developing id's Quake III Arena" \
      org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Labmonkeys Space" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT" \
      io.artifacthub.package.readme-url="https://github.com/labmonkeys-space/game-container/blob/main/ioquake3/README.md"
