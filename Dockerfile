FROM zenato/puppeteer

WORKDIR /data

ADD *.js ./
ADD *.json ./
RUN npm install --only=dev && \
      npm run prepublishOnly && \
      npm install

ENTRYPOINT ["node", "/data/index.bundle.js"]
CMD ["--help"]
