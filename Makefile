rust:
	docker build --target RUST -t prisma2:rust-stage ./docker

buster:
	docker build --build-arg NODE_TAG=buster --build-arg RUST_TAG=buster -t prisma2:buster ./docker

.PHONY: rust buster
