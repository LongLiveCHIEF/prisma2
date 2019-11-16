ARG RUST_TAG=latest
ARG NODE_TAG=latest

FROM rust:${RUST_TAG} AS RUST

WORKDIR /prisma-engine

ARG GITHUB_HOST=github.com
ARG DOWNLOAD_PROTOCOL=https
ARG CURL_ARGS=-L

RUN curl ${CURL_ARGS} ${DOWNLOAD_PROTOCOL}://${GITHUB_HOST}/prisma/prisma-engine/tarball/master \
  | tar xz

RUN cargo

# build prisma2 cli
FROM node:${NODE_TAG} AS NODE

ARG NPM_CONFIG_REGISTRY=https://registry.npmjs.org

RUN npm install --global prisma2

COPY --from=RUST /prisma-engine /tmp


# copy binaries to path that @prisma/fetch-engine
# RUN cp

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh]

CMD ["prisma2"]
