FROM pandoc/core:3.6

ARG UID=1000
ARG GID=1000

RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    freetype-dev \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    yarn

RUN addgroup -S pptruser -g $GID && adduser -S -G pptruser -u $UID pptruser \
    && mkdir -p /home/pptruser \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /data

USER $UID
WORKDIR /home/pptruser

RUN yarn add puppeteer mermaid-filter

COPY <<EOF .puppeteer.json
{
  "executablePath": "/usr/bin/chromium-browser",
  "args": [
    "--no-sandbox",
    "--disable-setuid-sandbox",
    "--headless",
    "--disable-gpu"
  ]
}
EOF

WORKDIR /data

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
    MERMAID_FILTER_PUPPETEER_CONFIG="/home/pptruser/.puppeteer.json" \
    PATH="/home/pptruser/node_modules/.bin:${PATH}" \
    XDG_CONFIG_HOME=/tmp/.chromium \
    XDG_CACHE_HOME=/tmp/.chromium