FROM alpine:edge
RUN apk add --no-cache \
	gcc-arm-none-eabi \
	g++-arm-none-eabi \
	gdb-multiarch \
	lz4 \
	python3 \
	git \
	clang-extra-tools \
	samurai \
	ccache \
	cmake
