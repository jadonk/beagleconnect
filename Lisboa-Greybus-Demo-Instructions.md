# Install some Ubuntu dependencies
apt install libnl-genl-3-dev libbluetooth-dev libavahi-client-dev

# Install OpenOCD, dtc

# Build Greybus Out-of-Kernel (required due to gb-netlink)
git clone git@github.com:friedtco/greybus.git
cd greybus
make -j
# Make sure you're using bash not dash for this script.
# See https://anandmpandit.blogspot.com/2011/09/how-to-change-default-shell-from-dash.html
./gbprobe.sh
cd ..

# Check out pygbmodule (set of scripts for dealing with greybus)
git clone https://github.com/cfriedt/pygbmodule

# Get the tool to compile Greybus manifests (manifesto)
git clone https://github.com/projectara/manifesto

# Download and install the GNU ARM Embedded Toolchain (required by Zephyr)
# https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
# install to /opt/arm

# Build gbridge (there are some dependencies, see readme, also openssl)
git clone git@github.com:friedtco/gbridge.git
cd gbridge
autoreconf -vfi
GBDIR="${PWD}/../greybus" ./configure --enable-uart --enable-tcpip --disable-gbsim --enable-netlink --disable-bluetooth --with-ssl
make -j

# Check out Zephyr
pip3 install --user west
west init zephyrproject
cd zephyrproject
west update
pip3 install --user -r zephyr/scripts/requirements.txt
cd zephyr
# to use lisboa zephyr fork
git remote rename origin upstream
git remote add origin git@github.com:friedtco/zephyr.git
git fetch origin
git checkout -b feature/1/zephyr-automated-builds origin/feature/1/zephyr-automated-builds
source zephyr-env.sh
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
export GNUARMEMB_TOOLCHAIN_PATH=/opt/arm/gcc-arm-none-eabi-8-2019-q3-update
west build --pristine -b cc1352r1_launchxl samples/subsys/greybus
# can also be done with
# openocd -f board/ti_cc13x2_launchpad.cfg -c "init" -c "reset halt" -c "reset_config trst_only" -c "flash write_image erase $PWD/build/zephyr/zephyr.elf"
west flash

cd ../pygbmodule
../manifesto/manifesto -o manifest.mnfb manifest.mnfs
./flash.py /dev/ttyACM0 manifest.mnfb

cd ../gbridge
./gbridge -p /dev/ttyACM0 -b 115200

# In a separate shell, take note of your virtual gpio pin number
ls -la /dev/gpiochip0
ls -la /sys/class/gpio
# Configure the green LED as output and turn it on
echo 511 > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio511/direction
echo 1 > /sys/class/gpio/gpio511/value