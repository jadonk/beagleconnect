################################################################################
#
# wpanusb-module
#
################################################################################

WPANUSB_MODULE_SITE = $(BR2_EXTERNAL_beagleconnect_gateway_PATH)/../linux/wpanusb
WPANUSB_MODULE_SITE_METHOD = local
WPANUSB_MODULE_LICENSE = GPL-2.0

WPANUSB_MODULE_MAKE_OPTS = KDIR=$(LINUX_VERSION_PROBED)

$(eval $(kernel-module))
$(eval $(generic-package))
