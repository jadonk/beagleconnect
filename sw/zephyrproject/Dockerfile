FROM arm32v7/debian:bullseye as build

ENV DEBIAN_FRONTEND=nonineractive

# rcn-ee repo required for latest CMake
RUN echo . \
	&& apt update \
	&& apt install -y gnupg \
	&& echo "deb [arch=armhf] http://repos.rcn-ee.net/debian/ bullseye main" >> /etc/apt/sources.list \
	&& apt-key adv --batch --keyserver keyserver.ubuntu.com --recv-key D284E608A4C46402 \
	&& apt update \
	&& apt install -y \
		git vim \
		build-essential \
		cmake ninja-build gperf \
		ccache dfu-util device-tree-compiler \
		make gcc libsdl2-dev \
		libxml2-dev libxslt-dev libssl-dev libjpeg62-turbo-dev \
		gcc-arm-none-eabi libnewlib-arm-none-eabi \
		libtool-bin pkg-config autoconf automake libusb-1.0-0-dev \
		python3-dev python3-pip python3-setuptools python3-tk python3-wheel \
	&& echo .
RUN pip3 install -U west

RUN echo . \
	&& mkdir -p /usr/src/openocd \
	&& cd /usr/src/openocd \
	&& git clone https://github.com/zephyrproject-rtos/openocd --depth 1 -b zephyr-20200722 \
	&& cd openocd && ./bootstrap && ./configure --enable-ftdi --disable-doxygen-html && make && make install \
	&& cd / && rm -rf /usr/src/openocd

WORKDIR /opt/source
RUN echo . \
	&& touch . \
	&& west init -m https://github.com/jadonk/zephyr --mr bcf-sdk-0.0.4 bcf-zephyr \
	&& echo .

WORKDIR /opt/source/bcf-zephyr
RUN echo . \
	&& west update \
	&& west zephyr-export \
	&& pip3 install -r zephyr/scripts/requirements-base.txt \
	&& echo .

ENV ZEPHYR_TOOLCHAIN_VAIRANT=cross-compile
ENV CROSS_COMPILE=/usr/bin/arm-none-eabi-
ENV ZEPHYR_BASE=/opt/source/bcf-zephyr/zephyr
ENV PATH=/opt/source/bcf-zephyr/zephyr/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV BOARD=beagleconnect_freedom

RUN echo . \
	&& echo "source /opt/source/bcf-zephyr/zephyr/zephyr-env.sh" >> /root/.bashrc \
	&& echo .

RUN echo . \
	&& west build -d sensortest zephyr/samples/boards/beagle_bcf/sensortest \
	&& echo .

ENV ZEPHYR_BASE=/root/src/bcf-zephyr/zephyr
ENV PATH=/root/src/bcf-zephyr/zephyr/scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo . \
	&& west build -b beagleconnect_freedom zephyr/samples/boards/beagle_bcf/sensortest \
	&& echo .