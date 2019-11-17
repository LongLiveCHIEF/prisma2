prisma2_lib = /usr/local/lib/node_modules/prisma2
query_binary = $(prisma2_lib)/prisma
migration_binary= $(prisma2_lib)/migration-engine
binary_args = --build-arg PRISMA_QUERY_ENGINE_BINARY=$(query_binary) --build-arg PRISMA_MIGRATION_ENGINE_BINARY=$(migration_binary)

rust:
	docker build --target RUST -t prisma2:rust-stage ./docker

buster:
	docker build $(binary_args) --build-arg NODE_TAG=buster --build-arg RUST_TAG=buster -t prisma2:buster ./docker

.PHONY: rust buster
