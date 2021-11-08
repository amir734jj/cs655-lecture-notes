FROM marpteam/marp-cli AS build-pdf
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build

FROM node:lts-alpine AS web-server
WORKDIR /usr/src/app
COPY --from=build-pdf /usr/src/app .
RUN npm install
EXPOSE 80
ENTRYPOINT ["/usr/bin/env"]
CMD ["npm", "start"]