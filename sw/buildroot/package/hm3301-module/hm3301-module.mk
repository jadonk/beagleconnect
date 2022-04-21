################################################################################
#
# hm3301-module
#
################################################################################

HM3301_MODULE_SITE = $(BR2_EXTERNAL_beagleconnect_gateway_PATH)/../linux/hm3301
HM3301_MODULE_SITE_METHOD = local
HM3301_MODULE_LICENSE = GPL-2.0

$(eval $(kernel-module))
$(eval $(generic-package))
