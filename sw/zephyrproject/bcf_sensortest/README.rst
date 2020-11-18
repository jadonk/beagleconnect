.. _ti-cc1352r_sensortag:

CC1352R SensorTag Demo
######################

Overview
********

This sample demonstrates some of the capabilities of the CC1352R SensorTag by
exercising GPIO output, GPIO input, as well as I2C and SPI I/O with the on-board
sensors.

* Cycle through Red, Green, and Blue LEDs every 500 ms
* Respond to Button press events with a console message
* Print out sensor readings on the Zephyr Shell

Requirements
************

Building, Flashing and Running
******************************

.. zephyr-app-commands::
   :zephyr-app: samples/boards/ti/cc1352r_sensortag
   :board: cc1352r_sensortag
   :goals: build flash
   :compact:

Sample Output
=============

Initialization
--------------

After reset, the red, green, and blue LEDs should immediately begin to change
every 500 ms and the following message should appear on the console.

.. code-block:: console

        *** Booting Zephyr OS build v2.4.0-rc1-283-gf239276916a5  ***
        [00:00:00.018,218] <inf> ti_cc1352r_sensortag: opening device Red LED
        [00:00:00.018,218] <inf> ti_cc1352r_sensortag: opening device Green LED
        [00:00:00.018,249] <inf> ti_cc1352r_sensortag: opening device Blue LED
        [00:00:00.018,249] <inf> ti_cc1352r_sensortag: opening device Push button 1
        [00:00:00.018,280] <inf> ti_cc1352r_sensortag: opening device Push button 2
        [00:00:00.018,310] <inf> ti_cc1352r_sensortag: opening device OPT3001
        [00:00:00.018,310] <inf> ti_cc1352r_sensortag: opening device ADXL362
        uart:~$

Ambient Light Sensor
--------------------

Here, we will demonstrate using the ambient light sensor via the Zephyr Shell.

First, take a reading of the ambient light.

.. code-block:: console

        uart:~$ sensor get OPT3001
        channel idx=17 light = 106.640000

Then, cover the ambient light sensor (located where the ☀️symbol is) and
take a second reading.

.. code-block:: console

        uart:~$ sensor get OPT3001
        channel idx=17 light =   0.850000

Accelerometer
-------------

Here we will take a number of (uncalibrated) readings of the acceleration due
to gravity using the Zephyr Shell.

First, rest the CC1352R SensorTag so that the Sub-1GHz antenna is pointing up
and the red printed circuit board is facing you. Then, take a reading.

.. code-block:: console

        uart:~$ sensor get ADXL362
        channel idx=0 accel_x =  -0.480525
        channel idx=1 accel_y = -10.738281
        channel idx=2 accel_z =   1.490610
        channel idx=12 die_temp = -26.000000

This reading indicates that the acceleration due to gravity in the y direction
is approximately -10 m/s^2.

Then, rotate the CC1352R SensorTag 90° clockwise, so that the Sub-1GHz antenna
is pointing right, and take a second reading.

.. code-block:: console

        uart:~$ sensor get ADXL362
        channel idx=0 accel_x =   9.286897
        channel idx=1 accel_y =   0.117679
        channel idx=2 accel_z =   1.441577
        channel idx=12 die_temp = -25.935000

This reading indicates that the acceleration due to gravity in the x direction
is 9 m/s^2.

Lastly, rest the CC1352R SensorTag flat so that the Sub-1GHz antenna is
pointing away from you, and take a third reading.

.. code-block:: console

        uart:~$ sensor get ADXL362
        channel idx=0 accel_x =  -0.823758
        channel idx=1 accel_y =   0.235359
        channel idx=2 accel_z =  11.169774
        channel idx=12 die_temp = -25.675000

This reading indicates that the acceleration due to gravity in the z direction
is 11 m/s^2.

Button Events
-------------

Here we will demonstrate button events being logged to the console.

Note, that there is a small delay between when the event occurs and when the
event is logged. Also note, that only button press events trigger events in
this demonstration, and not button release events.

.. code-block:: console

        uart:~$
        [00:00:02.377,227] <inf> ti_cc1352r_sensortag: Push button 1 event
        [00:00:04.062,561] <inf> ti_cc1352r_sensortag: Push button 2 event

In this sample application, if we push the buttons within 100 ms of each
other, then we also trigger each of the sensor values to be displayed.

.. code-block:: console

        uart:~$
        [00:00:01.713,226] <inf> ti_cc1352r_sensortag: Push button 2 event
        [00:00:01.713,928] <inf> ti_cc1352r_sensortag: Push button 1 event
        [00:00:01.714,508] <inf> ti_cc1352r_sensortag: OPT3001:  1.700000
        [00:00:01.714,599] <inf> ti_cc1352r_sensortag: ADXL362: x: -2.118236
        [00:00:01.714,599] <inf> ti_cc1352r_sensortag: ADXL362: y:  0.166713
        [00:00:01.714,630] <inf> ti_cc1352r_sensortag: ADXL362: z:  11.012867

Additional Sensors
------------------

At this time, Zephyr does not include a driver for the HDC2080 humidity
and temperature sensor from Texas Instruments. However, we are able to
read arbitrary registers via the I2C shell. The HDC2080 is located at
I2C address 0x41 and the identity register is at device address 0xfc.

.. code-block:: console

        uart:~$ i2c read I2C_0 41 fc
        00000000: 49 54 d0 07 00 00 00 00  00 00 00 00 00 00 00 ff |IT...... ........|
