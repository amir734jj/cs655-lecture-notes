FROM marpteam/marp-cli

WORKDIR /usr/src/app

COPY . .

RUN npm install

EXPOSE 80

ENTRYPOINT ["/usr/bin/env"]

CMD ["npm", "start"]
