FROM cgr.dev/chainguard/node:latest-dev
ARG OPENCLAW_VERSION='latest'
ARG GOG_VERSION='v0.11.0'

USER root

# Install apk packages
RUN apk update \
  && apk add --no-cache go chromium

# Build gog CLI
RUN git clone https://github.com/steipete/gogcli.git -b ${GOG_VERSION} /gogcli \
  && cd /gogcli && make BIN_DIR=/usr/local/bin/

USER 65532

ENV HOME=/app

RUN npm install openclaw@${OPENCLAW_VERSION}

ENTRYPOINT ["npx", "openclaw"]
