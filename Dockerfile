FROM node:alpine AS build

ARG VERSION=1.4.2

RUN apk add --no-cache git

RUN wget -q -O iframely.zip https://github.com/itteco/iframely/archive/v${VERSION}.zip
RUN unzip iframely.zip
RUN mv iframely-${VERSION}/ iframely/
RUN cd iframely; npm install -q

FROM node:alpine

WORKDIR /src

COPY --from=build /iframely /src

CMD ["node", "server"]
