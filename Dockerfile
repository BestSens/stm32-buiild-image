FROM alpine:3.20
RUN apk add --no-cache \
	gcc-arm-none-eabi \
	g++-arm-none-eabi \
	gdb-multiarch \
	lz4 \
	python3 \
	py3-ecdsa \
	git \
	clang-extra-tools \
	samurai \
	ccache \
	cmake \
	bash \
	curl \
	openssh-client \
	tar

ADD bestsens-SERVER-CA.crt /usr/share/ca-certificates/bestsens/bestsens-SERVER-CA.crt
RUN cat /usr/share/ca-certificates/bestsens/bestsens-SERVER-CA.crt >> /etc/ssl/certs/ca-certificates.cr