###
# Do not edit the generated Dockerfile
###

# hadolint ignore=DL3006
FROM "${BUILDER_BASE_IMAGE}" as builder

USER root

RUN apt-get update && \
    # hadolint ignore=DL3008
    apt-get install -y --no-install-recommends libsdl2-dev

RUN git clone https://github.com/ioquake/ioq3.git
RUN cd ioq3 && make release

# hadolint ignore=DL3006
FROM "${BASE_IMAGE}"

RUN adduser --system ioq3

COPY --chown=ioq3 --from=builder /home/circleci/project/ioq3/build/release-linux-x86_64 /opt/ioquake3

USER ioq3

ENTRYPOINT [ "/opt/ioquake3/ioq3ded.x86_64" ]

CMD [ "-v" ]

### Runtime information and not relevant at build time

EXPOSE 27960/udp

LABEL org.opencontainers.image.source="${VCS_SOURCE}" \
      org.opencontainers.image.revision="${VCS_REVISION}" \
      org.opencontainers.image.vendor="Labmonkeys Space" \
      org.opencontainers.image.authors="ronny@no42.org" \
      org.opencontainers.image.licenses="MIT"
