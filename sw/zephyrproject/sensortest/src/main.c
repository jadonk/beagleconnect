/*
 * Copyright (c) 2020 Friedt Professional Engineering Services, Inc
 * Copyright (c) 2020 Jason Kridner
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr.h>
#include <device.h>
#include <drivers/gpio.h>
#include <drivers/led.h>
#include <drivers/sensor.h>
#include <drivers/spi.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <net/net_ip.h>
#include <net/socket.h>
#include <sys/util.h>
#include <random/rand32.h>

#define LOG_LEVEL LOG_LEVEL_INF
#include <logging/log.h>
LOG_MODULE_REGISTER(sensortest);

#define BLINK_MS 500

#define MAX_STR_LEN 200
static char outstr[MAX_STR_LEN];

enum api {
	LED_API,
	BUTTON_API,
	SENSOR_API,
};

enum edev {
	LED_24G,
	LED_SUBG,
	BUTTON,
	LIGHT,
	ACCEL,
	HUMIDITY,
	ENVIRONMENT,
	AIRQUALITY,
	PARTICULATE,
	NUM_DEVICES,
};

struct led_work {
	uint8_t active_led;
	struct k_delayed_work dwork;
};

static void sensor_work_handler(struct k_work *work);

static const char *device_labels[NUM_DEVICES] = {
	[LED_SUBG] = DT_LABEL(DT_ALIAS(led0)),
	[LED_24G] = DT_LABEL(DT_ALIAS(led1)),
	[BUTTON] = DT_LABEL(DT_ALIAS(sw0)),
	[LIGHT] = "LIGHT",
	[ACCEL] = "ACCEL",
	[HUMIDITY] = "HUMIDITY",
	[ENVIRONMENT] = "ENVIRONMENT",
	[AIRQUALITY] = "AIRQUALITY",
	[PARTICULATE] = "PARTICULATE",
};

static const char *device_names[NUM_DEVICES] = {
	[LED_SUBG] = DT_GPIO_LABEL(DT_ALIAS(led1), gpios),
	[LED_24G] = DT_GPIO_LABEL(DT_ALIAS(led0), gpios),
	[BUTTON] = DT_GPIO_LABEL(DT_ALIAS(sw0), gpios),
	[LIGHT] = "OPT3001-LIGHT",
	[ACCEL] = "LIS2DE12-ACCEL",
	[HUMIDITY] = "HDC2010-HUMIDITY",
	[ENVIRONMENT] = "BME680-ENVIRONMENT",
	[AIRQUALITY] = "SGP30-AIRQUALITY",
	[PARTICULATE] = "HM3301-PARTICULATE",
};

static const uint8_t device_pins[NUM_DEVICES] = {
	[LED_SUBG] = DT_GPIO_PIN(DT_ALIAS(led0), gpios),
	[LED_24G] = DT_GPIO_PIN(DT_ALIAS(led1), gpios),
	[BUTTON] = DT_GPIO_PIN(DT_ALIAS(sw0), gpios),
};

static const enum api apis[NUM_DEVICES] = {
	LED_API,    LED_API,    BUTTON_API,
	SENSOR_API, /* LIGHT */
	SENSOR_API, /* ACCEL */
	SENSOR_API, /* HUMIDITY */
	SENSOR_API, /* ENVIRONMENT */
	SENSOR_API, /* AIRQUALITY */
	SENSOR_API, /* PARTICULATE */
};

static struct device *devices[NUM_DEVICES];

static struct led_work led_work;
K_WORK_DEFINE(sensor_work, sensor_work_handler);
static struct gpio_callback button_callback;

static struct sockaddr_in6 addr;
static int fd = -1;

/* Set TIMED_SENSOR_READ to 0 to disable */
#define TIMED_SENSOR_READ 60
static int sensor_read_count = TIMED_SENSOR_READ;

static void led_work_handler(struct k_work *work)
{
	ARG_UNUSED(work);

	int r;
	uint8_t prev_led;

	LOG_DBG("%s(): active_led: %u", __func__, led_work.active_led);

	if (led_work.active_led == LED_SUBG) {
		prev_led = LED_24G;
	} else {
		prev_led = LED_SUBG;
	}

	r = gpio_pin_set(devices[prev_led], device_pins[prev_led], 0);
	__ASSERT(r == 0, "failed to turn off led %u: %d", prev_led, r);

	r = gpio_pin_set(devices[led_work.active_led],
			 device_pins[led_work.active_led], 1);
	__ASSERT(r == 0, "failed to turn on led %u: %d", led_work.active_led,
		 r);

	if (led_work.active_led == LED_SUBG) {
		led_work.active_led = LED_24G;
	} else {
		led_work.active_led = LED_SUBG;
	}

	r = k_delayed_work_submit(&led_work.dwork, K_MSEC(BLINK_MS));
	__ASSERT(r == 0, "k_delayed_work_submit() failed for LED %u work: %d",
		 led_work.active_led, r);

	if (sensor_read_count > 0) {
		sensor_read_count--;
		if (sensor_read_count <= 0) {
			sensor_read_count = TIMED_SENSOR_READ;
			if(TIMED_SENSOR_READ > 0)
				sensor_read_count +=
				       	sys_rand32_get() % TIMED_SENSOR_READ;
			k_work_submit(&sensor_work);
		}
	}
}

static void print_sensor_value(size_t idx, const char *chan,
			       struct sensor_value *val)
{
	LOG_INF("%s: %s%d,%d", device_labels[idx], chan, val->val1, val->val2);

	sprintf(outstr+strlen(outstr), "%d%c:", idx, chan[0]);
	sprintf(outstr+strlen(outstr), "%d", val->val1);
	if (val->val2 != 0) {
		sprintf(outstr+strlen(outstr), ".%02d;", abs(val->val2) / 10000);
	} else {
		sprintf(outstr+strlen(outstr), ";");
	}
}

static void send_sensor_value()
{
	if ((fd >= 0) && (strlen(outstr) > 0)) {
		//LOG_INF("%s", log_strdup(outstr));
		sendto(fd, outstr, strlen(outstr), 0,
			(const struct sockaddr *) &addr,
			sizeof(addr));
	}

	outstr[0] = '\0';
}

static void sensor_work_handler(struct k_work *work)
{
	struct sensor_value val;
	struct sensor_value th[2] = {{0,0}, {0,0}}; /* calibration data for SGP30 */

	outstr[0] = '\0';

	for (size_t i = 0; i < NUM_DEVICES; ++i) {
		if (apis[i] != SENSOR_API) {
			continue;
		}

		if (devices[i] == NULL) {
			continue;
		}

		sensor_sample_fetch(devices[i]);

		if (i == LIGHT) {
			sensor_channel_get(devices[i], SENSOR_CHAN_LIGHT, &val);
			print_sensor_value(i, "l: ", &val);
			send_sensor_value();
			continue;
		}

		if (i == ACCEL) {
			sensor_channel_get(devices[i], SENSOR_CHAN_ACCEL_X,
					   &val);
			print_sensor_value(i, "x: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_ACCEL_Y,
					   &val);
			print_sensor_value(i, "y: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_ACCEL_Z,
					   &val);
			print_sensor_value(i, "z: ", &val);
			send_sensor_value();
			continue;
		}

		if (i == HUMIDITY) {
			sensor_channel_get(devices[i], SENSOR_CHAN_HUMIDITY,
					   &val);
			print_sensor_value(i, "h: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_AMBIENT_TEMP,
					   &val);
			print_sensor_value(i, "t: ", &val);
			send_sensor_value();
			continue;
		}

		if (i == ENVIRONMENT) {
			sensor_channel_get(devices[i], SENSOR_CHAN_AMBIENT_TEMP, &val);
			th[0].val1 = val.val1;
			th[0].val2 = val.val2;
			print_sensor_value(i, "t: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_PRESS, &val);
			print_sensor_value(i, "p: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_HUMIDITY, &val);
			th[1].val1 = val.val1;
			th[1].val2 = val.val2;
			print_sensor_value(i, "h: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_GAS_RES, &val);
			print_sensor_value(i, "g: ", &val);
			send_sensor_value();
			continue;
		}
		
		if (i == AIRQUALITY) {
			sensor_channel_get(devices[i], SENSOR_CHAN_VOC, &val);
			print_sensor_value(i, "v: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_CO2, &val);
			print_sensor_value(i, "c: ", &val);
			if(th[0].val1 != 0) {
				sensor_attr_set(devices[i], SENSOR_CHAN_VOC,
					SENSOR_ATTR_CALIB_TARGET, &th[0]);
			}
			send_sensor_value();
			continue;
		}

		if (i == PARTICULATE) {
			sensor_channel_get(devices[i], SENSOR_CHAN_PM_1_0, &val);
			print_sensor_value(i, "1: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_PM_2_5, &val);
			print_sensor_value(i, "2: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_PM_10, &val);
			print_sensor_value(i, "X: ", &val);
			send_sensor_value();
			continue;
		}
	}
}

static void button_handler(struct device *port, struct gpio_callback *cb,
			   gpio_port_pins_t pins)
{
	ARG_UNUSED(port);

	gpio_pin_t pin = device_pins[BUTTON];
	gpio_port_pins_t mask = BIT(pin);

	if ((mask & cb->pin_mask) != 0) {
		if ((mask & pins) != 0) {
			/* BEL (7) triggers BEEP on MSP430 */
			LOG_INF("%c%s event", 7, device_labels[BUTTON]);
			/* print sensor readings */
			k_work_submit(&sensor_work);
		}
	}
}

void main(void)
{
	int r;
	outstr[0] = '\0';

	fd = socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
	if (fd < 0) {
		LOG_ERR("failed to open socket");
	} else {
		memset(&addr, 0, sizeof(struct sockaddr_in6));
		addr.sin6_family = AF_INET6;
		addr.sin6_port = htons(9999);
		inet_pton(AF_INET6, "ff02::1", &addr.sin6_addr);
	}

	for (size_t i = 0; i < NUM_DEVICES; ++i) {
		LOG_INF("opening device %s", device_labels[i]);
		devices[i] =
			(struct device *)device_get_binding(device_names[i]);
		if (devices[i] == NULL) {
			LOG_ERR("failed to open device %s", device_labels[i]);
			continue;
		}

		/* per-device setup */
		switch (apis[i]) {
		case LED_API:
			r = gpio_pin_configure(devices[i], device_pins[i],
					       GPIO_OUTPUT_LOW);
			__ASSERT(r == 0,
				 "gpio_pin_configure(%s, %u, %x) failed: %d",
				 device_labels[i], device_pins[i],
				 GPIO_OUTPUT_LOW, r);
			break;
		case BUTTON_API:
			r = gpio_pin_configure(
				devices[i], device_pins[i],
				(GPIO_INPUT |
				 DT_GPIO_FLAGS(DT_ALIAS(sw0), gpios)));
			__ASSERT(r == 0,
				 "gpio_pin_configure(%s, %u, %x) failed: %d",
				 device_labels[i], device_pins[i],
				 (GPIO_INPUT |
				  DT_GPIO_FLAGS(DT_ALIAS(sw0), gpios)),
				 r);
			r = gpio_pin_interrupt_configure(
				devices[i], device_pins[i],
				GPIO_INT_EDGE_TO_ACTIVE);
			__ASSERT(
				r == 0,
				"gpio_pin_interrupt_configure(%s, %u, %x) failed: %d",
				device_labels[i], device_pins[i],
				GPIO_INT_EDGE_TO_ACTIVE, r);
			break;
		case SENSOR_API:
			break;
		default:
			break;
		}
	}

	/* setup timer-driven LED event */
	led_work.dwork.work.handler = led_work_handler;
	led_work.active_led = LED_SUBG;
	r = k_delayed_work_submit(&led_work.dwork, K_MSEC(BLINK_MS));
	__ASSERT(r == 0, "k_delayed_work_submit() failed for LED %u work: %d",
		 LED_SUBG, r);

	/* setup input-driven button event */
	gpio_init_callback(
		&button_callback, (gpio_callback_handler_t)button_handler,
		BIT(device_pins[BUTTON]));
	r = gpio_add_callback(devices[BUTTON], &button_callback);
	__ASSERT(r == 0, "gpio_add_callback() failed: %d", r);

	for (;;) {
		k_sleep(K_MSEC(1000));
	}
}
