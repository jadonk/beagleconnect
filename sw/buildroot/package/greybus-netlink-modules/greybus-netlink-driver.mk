################################################################################
#
# greybus-netlink-modules
#
################################################################################

GREYBUS_NETLINK_MODULES_SITE = $(BR2_EXTERNAL_beagleconnect_gateway_PATH)/../greybus
GREYBUS_NETLINK_MODULES_SITE_METHOD = local
GREYBUS_NETLINK_MODULES_LICENSE = GPL-2.0
GREYBUS_NETLINK_MODULES_LICENSE_FILES = LICENSE

GREYBUS_NETLINK_MODULES_MODULE_MAKE_OPTS = \
    KERNELVER='$(LINUX_VERSION)' KERNELDIR='$(LINUX_DIR)' \
    CC='$(TARGET_CC)' LD='$(TARGET_LD)'

$(eval $(kernel-module))
$(eval $(generic-package))
