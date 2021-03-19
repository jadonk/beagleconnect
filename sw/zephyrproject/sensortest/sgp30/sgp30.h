/*
 * Copyright (c) 2021 Jason Kridner
 *
 * This driver is guided by the BME680 driver as a skeleton and the Adafruit SGP30 sensor
 * Arduino driver and documentation.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef __SENSOR_SGP30_H__
#define __SENSOR_SGP30_H__

#include <device.h>
#include <zephyr/types.h>

#define SGP30_FEATURESET                0x0020
#define SGP30_CRC8_POLYNOMIAL           0x31
#define SGP30_CRC8_INIT                 0xFF
#define SGP30_WORD_LEN                  0x31

struct sgp_data {
	struct k_work sample_worker;
	const struct device *i2c_master;
	uint16_t i2c_slave_addr;
	uint16_t serialid[3];
	uint16_t featureset;

	uint16_t TVOC;
	uint16_t eCO2;
	uint16_t rawH2;
	uint16_t rawEthanol;

	uint16_t absoluteHumidity;
};

#endif /* __SENSOR_SGP30_H__ */
