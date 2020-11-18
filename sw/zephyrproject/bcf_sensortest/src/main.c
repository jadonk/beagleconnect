/*
 * Copyright (c) 2020 Friedt Professional Engineering Services, Inc
 *
 * Demo application for the cc1352r_sensortag
 *
 * - The application will blink red, green, and blue LEDs on startup
 * - When each button is pressed a message is printed to the console
 * - When both are pressed, sensor values are printed to the console
 *
 * Currently supported sensors include
 *
 * - OPT3001 ambient light sensor
 * - ADXL362 accelerometer
 *
 * Additional work needs to be done in the following areas:
 *
 * - Driver for the HDC2080 temperature and humidity sensor
 * - Driver for the DRV5032 Hall-effect sensor
 * - BLE for the cc13xx_cc26xx platform
 *
 * Optionally, it might be nice to present sensor readings via HTTP
 * either via 802.15.4/6LowPAN or BLE/6LowPAN.
 *
 * Alternatively, the Zephyr demo could be modified to work out of
 * the box with TI's Simplelink Starter app available for both
 * Android and iOS.
 *
 * For more information, please see
 * https://www.ti.com/tool/LPSTK-CC1352R
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <device.h>
#include <drivers/gpio.h>
#include <drivers/i2c.h>
#include <drivers/led.h>
#include <drivers/sensor.h>
#include <drivers/spi.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <sys/util.h>
#include <zephyr.h>

#define LOG_LEVEL LOG_LEVEL_INF
#include <logging/log.h>
LOG_MODULE_REGISTER(ti_cc1352r_sensortag);

#define BLINK_MS 500

enum api {
	LED_API,
	BUTTON_API,
	SENSOR_API,
};

enum edev {
	RED_LED,
	GREEN_LED,
	BLUE_LED,
	BUTTON1,
	BUTTON2,
	OPT3001,
	ADXL362,
	/* TODO: add support for hdc2080 */
	NUM_DEVICES,
};

struct led_work {
	uint8_t active_led;
	struct k_delayed_work dwork;
};

static void sensor_work_handler(struct k_work *work);

static const char *device_labels[NUM_DEVICES] = {
	[RED_LED] = DT_LABEL(DT_ALIAS(led1)),
	[GREEN_LED] = DT_LABEL(DT_ALIAS(led0)),
	[BLUE_LED] = DT_LABEL(DT_ALIAS(led2)),
	[BUTTON1] = DT_LABEL(DT_ALIAS(sw0)),
	[BUTTON2] = DT_LABEL(DT_ALIAS(sw1)),
	[OPT3001] = DT_LABEL(DT_ALIAS(sensor0)),
	[ADXL362] = DT_LABEL(DT_ALIAS(sensor1)),
	/* TODO: add support for hdc2080 */
};

static const char *device_names[NUM_DEVICES] = {
	[RED_LED] = DT_GPIO_LABEL(DT_ALIAS(led1), gpios),
	[GREEN_LED] = DT_GPIO_LABEL(DT_ALIAS(led0), gpios),
	[BLUE_LED] = DT_GPIO_LABEL(DT_ALIAS(led2), gpios),
	[BUTTON1] = DT_GPIO_LABEL(DT_ALIAS(sw0), gpios),
	[BUTTON2] = DT_GPIO_LABEL(DT_ALIAS(sw1), gpios),
	[OPT3001] = DT_LABEL(DT_ALIAS(sensor0)),
	[ADXL362] = DT_LABEL(DT_ALIAS(sensor1)),
	/* TODO: add support for hdc2080 */
};

static const uint8_t device_pins[NUM_DEVICES] = {
	[RED_LED] = DT_GPIO_PIN(DT_ALIAS(led1), gpios),
	[GREEN_LED] = DT_GPIO_PIN(DT_ALIAS(led0), gpios),
	[BLUE_LED] = DT_GPIO_PIN(DT_ALIAS(led2), gpios),
	[BUTTON1] = DT_GPIO_PIN(DT_ALIAS(sw0), gpios),
	[BUTTON2] = DT_GPIO_PIN(DT_ALIAS(sw1), gpios),
};

static const enum api apis[NUM_DEVICES] = {
	LED_API,    LED_API,	LED_API,    BUTTON_API,
	BUTTON_API, SENSOR_API, SENSOR_API,
	/* TODO: add support for hdc2080 */
};

static uint32_t event_times[NUM_DEVICES] = {
	[BUTTON1] = 0,
	[BUTTON2] = 0,
};

static struct device *devices[NUM_DEVICES];

static struct led_work led_work;
K_WORK_DEFINE(sensor_work, sensor_work_handler);
static struct gpio_callback button_callback;

static void led_work_handler(struct k_work *work)
{
	ARG_UNUSED(work);

	int r;
	uint8_t prev_led;

	/* red, green, blue #rgb */
	/* RED_LED <= led <= BLUE_LED must hold */

	LOG_DBG("%s(): active_led: %u", __func__, led_work.active_led);

	if (led_work.active_led == RED_LED) {
		prev_led = BLUE_LED;
	} else {
		prev_led = led_work.active_led - 1;
	}

	r = gpio_pin_set(devices[prev_led], device_pins[prev_led], 0);
	__ASSERT(r == 0, "failed to turn off led %u: %d", prev_led, r);

	r = gpio_pin_set(devices[led_work.active_led],
			 device_pins[led_work.active_led], 1);
	__ASSERT(r == 0, "failed to turn on led %u: %d", led_work.active_led,
		 r);

	if (led_work.active_led == BLUE_LED) {
		led_work.active_led = RED_LED;
	} else {
		led_work.active_led++;
	}

	r = k_delayed_work_submit(&led_work.dwork, K_MSEC(BLINK_MS));
	__ASSERT(r == 0, "k_delayed_work_submit() failed for LED %u work: %d",
		 led_work.active_led, r);
}

static void print_sensor_value(size_t idx, const char *chan,
			       struct sensor_value *val)
{
	char neg = ' ';

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

	LOG_INF("%s: %s%c%d.%06d", device_names[idx], chan, neg, val->val1,
		val->val2);
}

static void sensor_work_handler(struct k_work *work)
{
	struct sensor_value val;

	for (size_t i = 0; i < NUM_DEVICES; ++i) {
		if (apis[i] != SENSOR_API) {
			continue;
		}

		sensor_sample_fetch(devices[i]);

		if (i == OPT3001) {
			sensor_channel_get(devices[i], SENSOR_CHAN_LIGHT, &val);
			print_sensor_value(i, "", &val);
			continue;
		}

		if (i == ADXL362) {
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
	}
}

static void button_handler(struct device *port, struct gpio_callback *cb,
			   gpio_port_pins_t pins)
{
	ARG_UNUSED(port);

	for (uint8_t j = BUTTON1; j <= BUTTON2; ++j) {
		gpio_pin_t pin = device_pins[j];
		gpio_port_pins_t mask = BIT(pin);

		if ((mask & cb->pin_mask) != 0) {
			if ((mask & pins) != 0) {
				LOG_INF("%s event", device_labels[j]);
				event_times[j] = k_uptime_get_32();
			}
		}
	}

	uint32_t dt_ms;
	if (event_times[BUTTON1] >= event_times[BUTTON2]) {
		dt_ms = event_times[BUTTON1] - event_times[BUTTON2];
	} else {
		dt_ms = event_times[BUTTON2] - event_times[BUTTON1];
	}

	if (dt_ms <= 100) {
		/* print sensor readings */
		k_work_submit(&sensor_work);
		event_times[BUTTON1] = 0;
		event_times[BUTTON2] = 101;
	}
}

void main(void)
{
	int r;

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
	led_work.active_led = RED_LED;
	r = k_delayed_work_submit(&led_work.dwork, K_MSEC(BLINK_MS));
	__ASSERT(r == 0, "k_delayed_work_submit() failed for LED %u work: %d",
		 RED_LED, r);

	/* setup input-driven button event */
	gpio_init_callback(
		&button_callback, (gpio_callback_handler_t)button_handler,
		BIT(device_pins[BUTTON1]) | BIT(device_pins[BUTTON2]));
	r = gpio_add_callback(devices[BUTTON1], &button_callback);
	__ASSERT(r == 0, "gpio_add_callback() failed: %d", r);

	for (;;) {
		k_sleep(K_MSEC(1000));
	}
}
