/* sgp30.c - Driver for Sensiron's SGP30 temperature, pressure,
 * humidity and gas sensor
 *
 * https://www.sensirion.com/en/environmental-sensors/gas-sensors/sgp30/
 */

/*
 * Copyright (c) 2021 Jason Kridner
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#define DT_DRV_COMPAT sensiron_sgp30

#include "sgp30.h"
#include <drivers/i2c.h>
#include <init.h>
#include <kernel.h>
#include <sys/byteorder.h>
#include <sys/__assert.h>
#include <drivers/sensor.h>
#include <net/net_ip.h>

#include <logging/log.h>
LOG_MODULE_REGISTER(sgp30, CONFIG_SENSOR_LOG_LEVEL);

/* From Adafruit_SGP30 library */
static uint8_t sgp30_generateCRC(uint8_t *data)
{
	uint8_t crc = SGP30_CRC8_INIT;

	for (uint8_t i = 0; i < 2; i++) {
		crc ^= data[i];
		for (uint8_t b = 0; b < 8; b++) {
			if (crc & 0x80)
				crc = (crc << 1) ^ SGP30_CRC8_POLYNOMIAL;
			else
				crc <<= 1;
		}
	}

	return crc;
}

static int sgp30_cmd(struct sgp30_data *data, uint16_t command, uint16_t delay_ms,
		      uint16_t *reply_buf, size_t size)
{
	int ret;
	size_t i;
	uint8_t crc;
	uint32_t rb_size = (uint32_t)(size*2+size);
	uint8_t read_buf[9];
	uint16_t command_be = htons(command); /* make sure it is big endian */
	uint8_t *cmdp = (uint8_t *)&command_be;

	ret = i2c_write(data->i2c_master, cmdp, 2, data->i2c_slave_addr);
	if (ret < 0) {
		return ret;
	}

	if (delay_ms > 0) {
		k_msleep((uint32_t)delay_ms);
	}

	if (reply_buf == NULL || size == 0) {
		return 0;
	}

	if (size > 3) {
		return -EOVERFLOW;
	}

	ret = i2c_read(data->i2c_master, read_buf, rb_size,
		       	data->i2c_slave_addr);
	if (ret < 0) {
		return ret;
	}

	for (i = 0; i < size; i++) {
		crc = sgp30_generateCRC(read_buf + i * 3);
		if (crc != read_buf[i * 3 + 2])
			return -EBADMSG;
		reply_buf[i] = ntohs(*(uint16_t *)(read_buf + i * 3));
	}

	return 0;
}

static int sgp30_write(struct sgp30_data *data, uint16_t command,
		        uint16_t *val, size_t size)
{
	int ret;
	size_t i;
	uint32_t wb_size = 2+size*2+size;
	uint8_t write_buf[9];
	uint16_t be;
	uint8_t *bep;
       
	be = htons(command); /* make sure it is big endian */
	bep = (uint8_t *)&be;
	memcpy(write_buf, bep, 2);

	for (i = 0; i < size; i++) {
		be = htons(val[i]);
		bep = (uint8_t *)&be;
		memcpy(&write_buf[2 + i * 3], bep, 2);
		write_buf[4 + i * 3] = sgp30_generateCRC(bep);
	}

	ret = i2c_write(data->i2c_master, write_buf, wb_size, data->i2c_slave_addr);
	if (ret < 0) {
		return ret;
	}

	return 0;
}

static void sgp30_calc_iaq(struct sgp30_data *data, uint32_t adc_temp)
{
}

static int sgp30_sample_fetch(const struct device *dev)
{
	// NOP
	return 0;
}

static int sgp30_sample_read(const struct device *dev)
{
	struct sgp30_data *data = dev->data;
	uint16_t reply[3]; /* Size must include extra bytes for CRC */
	int ret;

	__ASSERT_NO_MSG(chan == SENSOR_CHAN_ALL);

	ret = sgp30_cmd(data, 0x2008, 12, reply, 2);
	if (ret < 0) {
		return ret;
	}

	data->TVOC = reply[1];
	data->eCO2 = reply[0];

	ret = sgp30_cmd(data, 0x2050, 25, reply, 2);
	if (ret < 0) {
		return ret;
	}

	data->rawEthanol = reply[1];
	data->rawH2 = reply[0];
	return 0;
}

static int sgp30_channel_get(const struct device *dev,
			      enum sensor_channel chan,
			      struct sensor_value *val)
{
	struct sgp30_data *data = dev->data;

	switch (chan) {
	case SENSOR_CHAN_VOC:
		/*
		 * TVOC in PPB
		 */
		val->val1 = (uint32_t)data->TVOC;
		val->val2 = 0;
		break;
	case SENSOR_CHAN_CO2:
		/*
		 * CO2 in PPM
		 */
		val->val1 = (uint32_t)data->eCO2;
		val->val2 = 0;
		break;
	default:
		return -EINVAL;
	}

	return 0;
}

static int sgp30_chip_init(const struct device *dev)
{
	struct sgp30_data *data = (struct sgp30_data *)dev->data;
	int err;

	/* Clear absoluteHumidity */
	data->absoluteHumidity = 0;

	/* Get Serial ID */
	err = sgp30_cmd(data, 0x3682, 1, data->serialid, 3);
	if (err < 0) {
		return err;
	}

	/* Check FEATURESET */
	err = sgp30_cmd(data, 0x202F, 10, &data->featureset, 1);
	if (err < 0) {
		return err;
	}
	if ((data->featureset & 0xF0) != SGP30_FEATURESET) {
		return -ENOTSUP;
	}

	/* Start IAQ algorithm */
	err = sgp30_cmd(data, 0x2003, 0, NULL, 0);
	if (err < 0) {
		return err;
	}

	return 0;
}

static void sgp30_sample_worker(struct k_work *work)
{
	int err;
	struct sgp30_data *data = 
		CONTAINER_OF(work, struct sgp30_data, sample_worker);

	err = sgp30_sample_read(data);
	if (err < 0) {
		printf("sgp30_sample_read error: %d\n", err);
	}
}

static void sgp30_timer(struct k_timer *timer)
{
	struct sgp30_data *data = timer->user_data;
	k_work_submit(&data->sample_worker);
}

static int sgp30_init(const struct device *dev)
{
	struct sgp30_data *data = dev->data;

	data->i2c_master = device_get_binding(
		DT_INST_BUS_LABEL(0));
	if (!data->i2c_master) {
		LOG_ERR("I2C master not found: %s",
			    DT_INST_BUS_LABEL(0));
		return -EINVAL;
	}

	data->i2c_slave_addr = DT_INST_REG_ADDR(0);

	if (sgp30_chip_init(dev) < 0) {
		return -EINVAL;
	}

	k_work_init(data->sample_worker, sgp30_sample_worker);
	k_timer_init(data->timer, sgp30_timer, NULL);
	data->timer->user_data = data;
	k_timer_start(data->timer, K_SECONDS(1), K_SECONDS(1));

	return 0;
}

static int sgp30_attr_set(const struct device *dev, enum sensor_channel chan,
			   enum sensor_attribute attr,
			   const struct sensor_value *val)
{
	struct sgp30_data *data = dev->data;

	return 0;
}

static const struct sensor_driver_api sgp30_api_funcs = {
	.channel_get = sgp30_channel_get,
	//.attr_set = sgp30_attr_set,
	//.attr_get = sgp30_attr_get,
};

static struct sgp30_data sgp30_data;

DEVICE_AND_API_INIT(sgp30, DT_INST_LABEL(0), sgp30_init, &sgp30_data,
		    NULL, POST_KERNEL, CONFIG_SENSOR_INIT_PRIORITY,
		    &sgp30_api_funcs);
