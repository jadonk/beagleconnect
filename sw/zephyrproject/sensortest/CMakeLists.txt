# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.13.1)
# set_property(GLOBAL PROPERTY CSTD gnu11)
include($ENV{ZEPHYR_BASE}/cmake/app/boilerplate.cmake NO_POLICY_SCOPE)
project(beagleconnect_freedom)

FILE(GLOB app_sources src/*.c)
target_sources(app PRIVATE ${app_sources})

#set(bsec_dir $ENV{ZEPHYR_BASE}/../../bosch/BSEC_1.4.8.0_Generic_Release)
#set(BSEC_LIB_DIR     ${bsec_dir}/algo/normal_version/bin/gcc/Cortex_M4F)
#set(BSEC_INCLUDE_DIR ${bsec_dir}/algo/normal_version/bin/gcc/Cortex_M4F)
#target_include_directories(app PRIVATE ${bsec_dir}/examples/bsec_iot_example)
#target_sources(app PRIVATE ${bsec_dir}/examples/bsec_iot_example/bme680.c)
#add_library(bsec_lib STATIC IMPORTED GLOBAL)
#add_dependencies(bsec_lib math_lib bsec_target)
#set_target_properties(bsec_lib PROPERTIES IMPORTED_LOCATION "${BSEC_LIB_DIR}/libalgobsec.a")
#set_target_properties(bsec_lib PROPERTIES INTERFACE_INCLUDE_DIRECTORIES ${BSEC_INCLUDE_DIR})
#target_link_libraries(bsec_lib INTERFACE -L${LIBC_LIBRARY_DIR})

