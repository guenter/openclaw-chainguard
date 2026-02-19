FROM cgr.dev/chainguard/node:latest-dev AS builder
ARG OPENCLAW_VERSION='latest'
ARG GOG_VERSION='v0.11.0'

USER root

# Install Go
RUN apk update \
  && apk add --no-cache go

# Build gog CLI
RUN git clone https://github.com/steipete/gogcli.git -b ${GOG_VERSION} /gogcli \
  && cd /gogcli && make

USER 65532

ENV HOME=/app

RUN npm install openclaw@${OPENCLAW_VERSION}

# Now create the final image without dev tools
FROM cgr.dev/chainguard/node:latest

ENV HOME=/app

COPY --from=builder /gogcli/bin/gog /usr/local/bin/gog
COPY --from=builder --chown=65532:65532 /app/ /app/

ENTRYPOINT ["npx", "openclaw"]
