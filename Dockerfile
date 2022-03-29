FROM debian:11
RUN apt-get update -y && apt-get install -y --no-install-recommends --no-install-suggests \
	python3-pip \
	python3-dev \
	curl \
	build-essential \
	wget \
	git \
	zsh \
	pkg-config \
	autoconf-archive \
	ca-certificates \
	libssl-dev \
	libncurses-dev \
	clang-format-11 \
	lcov \
	libc++-dev \
	ninja-build
RUN rm -Rf /var/lib/apt/lists/*
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN pip install conan && conan config set general.revisions_enabled=1 && conan profile new default --detect
RUN conan remote remove conancenter
RUN mkdir /root/Temp && cd /root/Temp
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.22.3.tar.gz -P /root/Temp && \
	tar -xzf /root/Temp/cmake-3.22.3.tar.gz -C /root/Temp && \
	/root/Temp/cmake-3.22.3/bootstrap && \
	make /root/Temp/cmake-3.22.3 && \
	make install /root/Temp/cmake-3.22.3
RUN wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -P /root/Temp && \
	tar -xf /root/Temp/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 -C /usr/share/ && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gcc /usr/bin/arm-none-eabi-gcc && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-g++ /usr/bin/arm-none-eabi-g++ && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-gdb /usr/bin/arm-none-eabi-gdb && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-size /usr/bin/arm-none-eabi-size && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ar /usr/bin/arm-none-eabi-ar && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-objcopy /usr/bin/arm-none-eabi-objcopy && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-objdump /usr/bin/arm-none-eabi-objdump && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-nm /usr/bin/arm-none-eabi-nm && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-strip /usr/bin/arm-none-eabi-strip && \
	ln -s /usr/share/gcc-arm-none-eabi-10.3-2021.10/bin/arm-none-eabi-ranlib /usr/bin/arm-none-eabi-ranlib && \
	ln -s /usr/lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5 && \
	ln -s /usr/lib/x86_64-linux-gnu/libtinfo.so.6 /usr/lib/x86_64-linux-gnu/libtinfo.so.5
RUN rm -Rf /root/Temp
CMD ["zsh"]