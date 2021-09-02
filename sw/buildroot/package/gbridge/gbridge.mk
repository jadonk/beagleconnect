################################################################################
#
# gbridge
#
################################################################################

GBRIDGE_SITE = $(BR2_EXTERNAL_beagleconnect_gateway_PATH)/../gbridge
GBRIDGE_SITE_METHOD = local
GBRIDGE_LICENSE = GPL-2.0
GBRIDGE_LICENSE_FILES = LICENSE
GBRIDGE_DEPENDENCIES = host-pkgconf

GBRIDGE_AUTORECONF = YES
GBRIDGE_AUTORECONF_OPTS = -vfi

GBRIDGE_CONF_OPTS = \
		   GBNETLINKDIR=$(BR2_EXTERNAL_beagleconnect_gateway_PATH)/../greybus \
		   --enable-uart \
		   --enable-tcpip \
		   --disable-gbsim \
		   --enable-netlink \
		   --disable-bluetooth

$(eval $(autotools-package))
