# ---
# mermaidをヘッドレスで動かすように以下ベースイメージを使用
#
# Dockerで日本語対応のHeadless Chrome + puppeteerを立ち上げ
# https://morizyun.github.io/blog/docker-compose-chrome-puppeteer-headless/index.html
#

FROM ubuntu:18.04

MAINTAINER morizyun <@zyunnosuke>

# For Japan
RUN sed -i -E "s@http://(archive|security)\.ubuntu\.com/ubuntu/@http://ftp.jaist.ac.jp/pub/Linux/ubuntu/@g" /etc/apt/sources.list

# Basic
RUN apt-get update \
    && apt-get install -y sudo curl wget zip unzip git nodejs npm fontconfig \
    && apt-get purge -y nodejs npm \
    && curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

# Chromeでビルドエラーとなるので修正
RUN apt-get update \
	&& apt-get install -y libgconf-2-4

# Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
    && apt-get update \
    && apt-get install -f -y google-chrome-stable 


# Remove cache & workfile
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Japanese font
RUN mkdir /noto
ADD https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /noto
WORKDIR /noto
RUN unzip NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/noto && \
    cp *.otf /usr/share/fonts/noto && \
    chmod 644 -R /usr/share/fonts/noto/ && \
    /usr/bin/fc-cache -fv
WORKDIR /
RUN rm -rf /noto

# Work dir
RUN mkdir -p /app
WORKDIR /app
COPY . /app/

#----
# 以下イメージファイルをベースとする
# https://github.com/jnewland/mermaid.cli

WORKDIR /data

ADD index.* package.json yarn.lock ./
RUN npm install && cp ./node_modules/mermaid/dist/mermaid.min.js . &&\
	npm run-script prepublishOnly

ADD test ./test
RUN node index.bundle.js -i ./test/flowchart.mmd -o /tmp/test.png; rm /tmp/test.png

ENTRYPOINT ["node", "/data/index.bundle.js"]
CMD ["--help"]
