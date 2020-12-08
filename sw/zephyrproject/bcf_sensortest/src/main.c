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

#define LOG_LEVEL LOG_LEVEL_INF
#include <logging/log.h>
LOG_MODULE_REGISTER(beagleconnect_freedom);

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
	[LIGHT] = DT_LABEL(DT_ALIAS(sensor0)),
	[ACCEL] = DT_LABEL(DT_ALIAS(sensor1)),
	[HUMIDITY] = DT_LABEL(DT_ALIAS(sensor2)),
	[ENVIRONMENT] = DT_LABEL(DT_ALIAS(click1)),
};

static const char *device_names[NUM_DEVICES] = {
	[LED_SUBG] = DT_GPIO_LABEL(DT_ALIAS(led1), gpios),
	[LED_24G] = DT_GPIO_LABEL(DT_ALIAS(led0), gpios),
	[BUTTON] = DT_GPIO_LABEL(DT_ALIAS(sw0), gpios),
	[LIGHT] = DT_LABEL(DT_ALIAS(sensor0)),
	[ACCEL] = DT_LABEL(DT_ALIAS(sensor1)),
	[HUMIDITY] = DT_LABEL(DT_ALIAS(sensor2)),
	[ENVIRONMENT] = DT_LABEL(DT_ALIAS(click1)),
};

static const uint8_t device_pins[NUM_DEVICES] = {
	[LED_SUBG] = DT_GPIO_PIN(DT_ALIAS(led0), gpios),
	[LED_24G] = DT_GPIO_PIN(DT_ALIAS(led1), gpios),
	[BUTTON] = DT_GPIO_PIN(DT_ALIAS(sw0), gpios),
};

static const enum api apis[NUM_DEVICES] = {
	LED_API,    LED_API,    BUTTON_API,
	SENSOR_API, SENSOR_API, SENSOR_API,
	SENSOR_API
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
			k_work_submit(&sensor_work);
		}
	}
}

static void print_sensor_value(size_t idx, const char *chan,
			       struct sensor_value *val)
{
	char neg = ' ';
	char str[20];

	/* see sensor.h */
	if (val->val1 < 0 && val->val2 < 0) {
		neg = '-';
		val->val1 = -val->val1;
		val->val2 = -val->val2;
	} else if (val->val1 >= 0 && val->val2 < 0) {
		neg = '-';
		val->val2 = -val->val2;
	} else if (val->val1 < 0 && val->val2 == 0) {
		neg = '-';
		val->val1 = -val->val1;
	}

	LOG_INF("%s: %s%c%d.%06d", device_names[idx], chan, neg, val->val1, val->val2);
	snprintf(str, 20, "%d%c:%c%d.%02d;", idx, chan[0], neg, val->val1, val->val2);
	strncat(outstr, str, MAX_STR_LEN - strnlen(outstr, MAX_STR_LEN));
}

static void sensor_work_handler(struct k_work *work)
{
	struct sensor_value val;

	outstr[0] = '\0';

	for (size_t i = 0; i < NUM_DEVICES; ++i) {
		if (apis[i] != SENSOR_API) {
			continue;
		}

		if (devices[i] < 0) {
			continue;
		}

		sensor_sample_fetch(devices[i]);

		if (i == LIGHT) {
			sensor_channel_get(devices[i], SENSOR_CHAN_LIGHT, &val);
			print_sensor_value(i, "l: ", &val);
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
			continue;
		}

		if (i == HUMIDITY) {
			sensor_channel_get(devices[i], SENSOR_CHAN_HUMIDITY,
					   &val);
			print_sensor_value(i, "h: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_AMBIENT_TEMP,
					   &val);
			print_sensor_value(i, "t: ", &val);
			continue;
		}

		if (i == ENVIRONMENT) {
			sensor_channel_get(devices[i], SENSOR_CHAN_AMBIENT_TEMP, &val);
			print_sensor_value(i, "t: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_PRESS, &val);
			print_sensor_value(i, "p: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_HUMIDITY, &val);
			print_sensor_value(i, "h: ", &val);
			sensor_channel_get(devices[i], SENSOR_CHAN_GAS_RES, &val);
			print_sensor_value(i, "g: ", &val);
		}
	}

	if ((fd >= 0) && (strnlen(outstr, MAX_STR_LEN) > 0))
		sendto(fd, outstr, strnlen(outstr, MAX_STR_LEN), 0,
			(const struct sockaddr *) &addr,
			sizeof(addr));
}

static void button_handler(struct device *port, struct gpio_callback *cb,
			   gpio_port_pins_t pins)
{
	ARG_UNUSED(port);

	gpio_pin_t pin = device_pins[BUTTON];
	gpio_port_pins_t mask = BIT(pin);

	if ((mask & cb->pin_mask) != 0) {
		if ((mask & pins) != 0) {
			LOG_INF("%s event", device_labels[BUTTON]);
			/* print sensor readings */
			k_work_submit(&sensor_work);
		}
	}
}

void main(void)
{
	int r;

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
