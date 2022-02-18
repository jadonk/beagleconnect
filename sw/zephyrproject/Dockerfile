FROM arm32v7/debian:bullseye as build

ENV DEBIAN_FRONTEND=nonineractive

RUN echo . \
	&& apt update \
	&& apt install -y gnupg \
	&& echo "deb [arch=armhf] http://repos.rcn-ee.net/debian/ bullseye main" >> /etc/apt/sources.list \
	&& apt-key adv --batch --keyserver keyserver.ubuntu.com --recv-key D284E608A4C46402 \
	&& apt update \
	&& apt install -y \
		build-essential \
		cmake ninja-build gperf \
		ccache dfu-util device-tree-compiler \
		make gcc libsdl2-dev \
		libxml2-dev libxslt-dev libssl-dev libjpeg62-turbo-dev \
		gcc-arm-none-eabi libnewlib-arm-none-eabi \
		libtool-bin pkg-config autoconf automake libusb-1.0-0-dev \
		python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
	&& echo .

RUN echo . \
	&& apt install -y \
		git \
	&& echo .

RUN echo . \
	&& mkdir -p /usr/src/openocd \
	&& cd /usr/src/openocd \
	&& git clone https://github.com/zephyrproject-rtos/openocd --depth 1 -b zephyr-20200722 \
	&& cd openocd && ./bootstrap && ./configure --enable-ftdi --disable-doxygen-html && make && make install \
	&& cd / && rm -rf /usr/src/openocd

RUN pip3 install -U west

WORKDIR /root/src
RUN echo . \
	&& touch . \
	&& west init -m https://github.com/jadonk/zephyr --mr bcf-sdk-0.0.3 bcf-zephyr \
	&& echo .

WORKDIR /root/src/bcf-zephyr
RUN echo . \
	&& west update \
	&& west zephyr-export \
	&& pip3 install -r zephyr/scripts/requirements-base.txt \
	&& echo .

ENV ZEPHYR_TOOLCHAIN_VAIRANT=cross-compile
ENV CROSS_COMPILE=/usr/bin/arm-none-eabi-
ENV ZEPHYR_BASE=/root/src/bcf-zephyr

RUN echo . \
	&& apt install -y \
		vim \
	&& echo .

RUN echo . \
	&& echo "source /root/src/bcf-zephyr/zephyr/zephyr-env.sh" >> /root/.bashrc \
	&& echo .

RUN echo . \
	&& echo "deb http://deb.debian.org/debian bullseye-backports main" > /etc/apt/sources.list.d/backports.list \
	&& apt update \
	&& apt install -y cmake/bullseye-backports \
	&& echo .

ENV ZEPHYR_BASE=/root/src/bcf-zephyr/zephyr
ENV PATH=/root/src/bcf-zephyr/zephyr/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo . \
	&& west build -b beagleconnect_freedom zephyr/samples/boards/beagle_bcf/sensortest \
	&& echo .
