ARG RUST_TAG=latest
ARG NODE_TAG=latest

FROM rust:${RUST_TAG} AS RUST

WORKDIR /prisma-engine

ARG GITHUB_HOST=github.com
ARG DOWNLOAD_PROTOCOL=https
ARG CURL_ARGS=-L

ARG CARGO_CRATES_INDEX=cargo.io
ARG CARGO_SOURCE_PROTOCOL=https

RUN curl ${CURL_ARGS} ${DOWNLOAD_PROTOCOL}://${GITHUB_HOST}/prisma/prisma-engine/tarball/master \
  | tar xz --strip 1

COPY ./scripts/cargo-config.sh /tmp/cargo-config.sh
RUN /tmp/cargo-config.sh
RUN cargo build --release

# build prisma2 cli
FROM node:${NODE_TAG} AS NODE

ARG NPM_CONFIG_REGISTRY=https://registry.npmjs.org
ENV NPM_CONFIG_REGISTRY=$NPM_CONFIG_REGISTRY

RUN npm install --global prisma2

COPY --from=RUST /prisma-engine/target/release /tmp
RUN find /tmp -mindepth 1 -type d | xargs rm -rf \
	&& rm -rf /tmp/*.*


COPY ./scripts/move-binaries.sh /tmp/move-binaries.sh
RUN /tmp/move-binaries.sh

COPY ./scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["prisma2"]
