FROM marpteam/marp-cli AS build-pdf
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

FROM boylanduwm/cool-compiler:latest AS web-server
WORKDIR /usr/src/app
RUN apk update && \
    apk add nodejs npm
COPY . .
COPY --from=build-pdf /usr/src/app/src ./src
RUN npm install
ENV NODE_ENV=production
EXPOSE 3000
ENTRYPOINT ["/usr/bin/env"]
CMD ["npm", "start"]