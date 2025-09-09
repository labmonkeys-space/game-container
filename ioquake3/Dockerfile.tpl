###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}" AS builder

WORKDIR /root

# hadolint ignore=DL3018, DL3003
RUN apk --no-cache add cmake git gcc sdl2-dev make musl-dev
RUN git clone https://github.com/ioquake/ioq3.git

WORKDIR /root/ioq3

RUN git checkout ${GIT_COMMIT}
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
RUN cmake --build build

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

RUN adduser --system ioq3 && \
    mkdir -p /opt/ioq3

COPY --chown=ioq3 --from=builder /root/ioq3/build/Release/ioq3ded /opt/ioq3

USER ioq3

ENTRYPOINT [ "/opt/ioq3/ioq3ded" ]

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
