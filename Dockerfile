FROM alpine:edge
RUN apk add --no-cache \
	gcc-arm-none-eabi \
	g++-arm-none-eabi \
	lz4 \
	python3 \
	samurai \
	cmake
