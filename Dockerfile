FROM cgr.dev/chainguard/node:latest-dev

WORKDIR /app

ENV HOME=/app

RUN npm install openclaw@latest

ENTRYPOINT ["npx", "openclaw"]
