FROM alpine:3.18
RUN apk add --no-cache \
	ninja-build \
	gcc-arm-none-eabi \
	g++-arm-none-eabi \
	lz4 \
	python3 \
	cmake

RUN ln -s /usr/lib/ninja-build/bin/ninja /usr/bin/ninja