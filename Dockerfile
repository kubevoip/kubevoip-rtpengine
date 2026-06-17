FROM debian:bookworm-slim
ARG RTPENGINE_VERSION=10.5.3.5-1
LABEL org.opencontainers.image.source="https://github.com/kubevoip/kubevoip-rtpengine" \
      org.opencontainers.image.title="KubeVoIP RTPengine" \
      org.opencontainers.image.description="RTPengine runtime image for KubeVoIP" \
      org.opencontainers.image.licenses="MIT"
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates rtpengine-daemon="${RTPENGINE_VERSION}" tini \
 && rm -rf /var/lib/apt/lists/* \
 && useradd --system --uid 10002 --home /run/rtpengine rtpengine-kubevoip \
 && mkdir -p /run/rtpengine \
 && chown -R rtpengine-kubevoip:rtpengine-kubevoip /run/rtpengine
USER 10002
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/bin/rtpengine"]
