FROM node:alpine AS build

ARG VERSION=2.2.0

RUN apk add --no-cache build-base git python3

RUN wget -q -O iframely.zip https://github.com/itteco/iframely/archive/v${VERSION}.zip
RUN unzip iframely.zip
RUN mv iframely-${VERSION}/ iframely/
RUN cd iframely; npm install -q

FROM node:alpine

WORKDIR /src

COPY --from=build /iframely /src

CMD ["node", "server"]
