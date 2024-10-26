FROM node:latest

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    apt-transport-https \
    chromium \
    chromium-driver \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium

WORKDIR /app

RUN npm i -g pm2

COPY package*.json ./

RUN npm ci --no-audit

COPY . .

EXPOSE 3000

CMD ["pm2-runtime", "src/index.js"]
