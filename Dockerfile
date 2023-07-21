FROM fedora:38
RUN dnf install -y \
	cmake \
	git \
	ninja-build \
	which \
	ccache \
	pkgconf \
	clang-tools-extra \
	wget \
	xz \
	gcc \
	make
RUN dnf clean all && rm -rf /var/cache/yum

RUN mkdir -p /root/Temp

ARG GCC_VERSION=12.2.rel1
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu/${GCC_VERSION}/binrel/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi.tar.xz -P /root/Temp && \
	tar -xf /root/Temp/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi.tar.xz -C /usr/share/ && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++ && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-ar /usr/bin/arm-none-eabi-ar && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc-ar /usr/bin/arm-none-eabi-gcc-ar && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-nm /usr/bin/arm-none-eabi-nm && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc-nm /usr/bin/arm-none-eabi-gcc-nm && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-strip /usr/bin/arm-none-eabi-strip && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-ranlib /usr/bin/arm-none-eabi-ranlib && \
	ln -s /usr/share/arm-gnu-toolchain-${GCC_VERSION}-x86_64-arm-none-eabi/bin/arm-none-eabi-gcc-ranlib /usr/bin/arm-none-eabi-gcc-ranlib

ARG LZ4_VERSION=1.9.4
RUN wget https://github.com/lz4/lz4/archive/refs/tags/v${LZ4_VERSION}.tar.gz -P /root/Temp && \
	tar -xf /root/Temp/v${LZ4_VERSION}.tar.gz -C /root/Temp && \
	cd /root/Temp/lz4-${LZ4_VERSION} && \
	make -j 6 && \
	make install

RUN rm -Rf /root/Temp