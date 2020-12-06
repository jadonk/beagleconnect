EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 10 10
Title "BeagleConnect Leash"
Date "2020-08-31"
Rev "A"
Comp ""
Comment1 "Schematic originally designed by Analog Life, LLC"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LeashPCB:HDC2010-LeashPCB U8
U 1 1 5E6C7D57
P 5425 3250
F 0 "U8" H 5725 2700 50  0000 C CNN
F 1 "HDC2010" H 5125 2700 50  0000 C CNN
F 2 "leash:HDC2010" H 5425 3400 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/hdc2010.pdf" H 5425 3400 50  0001 C CNN
F 4 "https://www.digikey.com/product-detail/en/texas-instruments/HDC2010YPAR/296-47774-2-ND/7561364" H 5425 3250 50  0001 C CNN "Link1"
F 5 "HDC2010YPAR" H 5425 3250 50  0001 C CNN "MPN1"
F 6 "GEN 2 HUMIDITY SENSOR" H 5425 3250 50  0001 C CNN "Short Description"
F 7 "0.2175" H 5425 3250 50  0001 C CNN "Standard Price"
F 8 "Texas Instruments" H 5425 3250 50  0001 C CNN "Vendor1"
F 9 "314010579" H 5425 3250 50  0001 C CNN "Seeed PN"
F 10 "HDC2010YPAR" H 5425 3250 50  0001 C CNN "MPN2"
F 11 "TI" H 5425 3250 50  0001 C CNN "Vendor2"
F 12 "SMD Humidity Sensor;DSBGA-6" H 5425 3250 50  0001 C CNN "Seeed Description"
	1    5425 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5425 2100 5425 2550
Text GLabel 4475 3000 0    50   Input ~ 0
SDA
Text GLabel 4475 3100 0    50   Input ~ 0
SCL
Wire Wire Line
	4925 3450 4850 3450
Wire Wire Line
	4250 3450 4250 3750
$Comp
L power:GND #PWR065
U 1 1 5E6C8A50
P 4250 3750
F 0 "#PWR065" H 4250 3500 50  0001 C CNN
F 1 "GND" H 4250 3600 50  0000 C CNN
F 2 "" H 4250 3750 50  0001 C CNN
F 3 "" H 4250 3750 50  0001 C CNN
	1    4250 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR068
U 1 1 5E6C8CC8
P 5425 4025
F 0 "#PWR068" H 5425 3775 50  0001 C CNN
F 1 "GND" H 5425 3875 50  0000 C CNN
F 2 "" H 5425 4025 50  0001 C CNN
F 3 "" H 5425 4025 50  0001 C CNN
	1    5425 4025
	1    0    0    -1  
$EndComp
Wire Wire Line
	4475 3000 4900 3000
$Comp
L Device:R R?
U 1 1 5E6D7582
P 4550 2500
AR Path="/5D062750/5E6D7582" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5E6D7582" Ref="R50"  Part="1" 
F 0 "R50" H 4620 2546 50  0000 L CNN
F 1 "2.21K" H 4620 2455 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4480 2500 50  0001 C CNN
F 3 "~" H 4550 2500 50  0001 C CNN
F 4 "RES SMD 2.21K OHM 1% 1/10W 0402" H 4550 2500 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/ERJ-2RKF2211X/P2.21KLTR-ND/192198" H 4550 2500 50  0001 C CNN "Link1"
F 6 "ERJ-2RKF2211X" H 4550 2500 50  0001 C CNN "MPN1"
F 7 "0.00498" H 4550 2500 50  0001 C CNN "Standard Price"
F 8 "Panasonic Electronic Components" H 4550 2500 50  0001 C CNN "Vendor1"
F 9 "RES SMD 2.21K OHM 1% 1/10W 0402" H 4550 2500 50  0001 C CNN "Short Description"
F 10 "301010881" H 4550 2500 50  0001 C CNN "Seeed PN"
F 11 "RC0402FR-072K21L" H 4550 2500 50  0001 C CNN "MPN2"
F 12 "SMD RES 2.21K-1%-1/16W;0402" H 4550 2500 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 4550 2500 50  0001 C CNN "Vendor2"
	1    4550 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E6DBE6D
P 4900 2500
AR Path="/5D062750/5E6DBE6D" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5E6DBE6D" Ref="R52"  Part="1" 
F 0 "R52" H 4970 2546 50  0000 L CNN
F 1 "2.21K" H 4970 2455 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4830 2500 50  0001 C CNN
F 3 "~" H 4900 2500 50  0001 C CNN
F 4 "RES SMD 2.21K OHM 1% 1/10W 0402" H 4900 2500 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/ERJ-2RKF2211X/P2.21KLTR-ND/192198" H 4900 2500 50  0001 C CNN "Link1"
F 6 "ERJ-2RKF2211X" H 4900 2500 50  0001 C CNN "MPN1"
F 7 "0.00498" H 4900 2500 50  0001 C CNN "Standard Price"
F 8 "Panasonic Electronic Components" H 4900 2500 50  0001 C CNN "Vendor1"
F 9 "RES SMD 2.21K OHM 1% 1/10W 0402" H 4900 2500 50  0001 C CNN "Short Description"
F 10 "301010881" H 4900 2500 50  0001 C CNN "Seeed PN"
F 11 "RC0402FR-072K21L" H 4900 2500 50  0001 C CNN "MPN2"
F 12 "SMD RES 2.21K-1%-1/16W;0402" H 4900 2500 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 4900 2500 50  0001 C CNN "Vendor2"
	1    4900 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2350 4900 2100
Connection ~ 4900 2100
Wire Wire Line
	4900 2100 5425 2100
Wire Wire Line
	4550 2100 4550 2350
Wire Wire Line
	4550 2650 4550 3100
Connection ~ 4550 2100
Wire Wire Line
	4550 2100 4900 2100
Connection ~ 4550 3100
Wire Wire Line
	4550 3100 4475 3100
Wire Wire Line
	4550 3100 4925 3100
Wire Wire Line
	4900 2650 4900 3000
Connection ~ 4900 3000
Wire Wire Line
	4900 3000 4925 3000
Wire Wire Line
	5425 4025 5425 3900
Text GLabel 9625 3250 2    50   Input ~ 0
INT_SENSOR
$Comp
L LeashPCB:LIS2DE12-lis2hh12 U9
U 1 1 5E74E78E
P 6150 5625
F 0 "U9" H 5950 6075 50  0000 R CNN
F 1 "LIS2DE12" H 6300 6075 50  0000 L CNN
F 2 "Package_LGA:LGA-12_2x2mm_P0.5mm" H 6300 6175 50  0001 L CNN
F 3 "https://www.st.com/resource/en/datasheet/lis2DE12.pdf" H 5800 5625 50  0001 C CNN
F 4 "https://www.digikey.com/products/en/sensors-transducers/motion-sensors-accelerometers/515?k=LIS2DE12&k=&pkeyword=LIS2DE12&sv=0&pv7=1&sf=0&FV=-8%7C515&quantity=&ColumnSort=0&page=1&pageSize=25" H 6150 5625 50  0001 C CNN "Link1"
F 5 "LIS2DE12TR" H 6150 5625 50  0001 C CNN "MPN1"
F 6 "ACCEL 2-16G I2C/SPI 12LGA" H 6150 5625 50  0001 C CNN "Short Description"
F 7 "0.51200" H 6150 5625 50  0001 C CNN "Standard Price"
F 8 "STMicroelectronics" H 6150 5625 50  0001 C CNN "Vendor1"
F 9 "314080306" H 6150 5625 50  0001 C CNN "Seeed PN"
F 10 "LIS2DE12TR" H 6150 5625 50  0001 C CNN "MPN2"
F 11 "（Fusion）SMD Motion & Position Sensor;LGA-12" H 6150 5625 50  0001 C CNN "Seeed Description"
F 12 "ST" H 6150 5625 50  0001 C CNN "Vendor2"
	1    6150 5625
	1    0    0    -1  
$EndComp
$Comp
L LeashPCB:OPT3001-LeashPCB U7
U 1 1 5E7503C1
P 2775 5725
F 0 "U7" H 2475 6075 50  0000 L CNN
F 1 "OPT3001" H 2825 6075 50  0000 L CNN
F 2 "leash:USON6" H 2775 6175 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/opt3001.pdf" H 2475 6075 50  0001 C CNN
F 4 "OPT3001DNPR" H 2775 5725 50  0001 C CNN "MPN1"
F 5 "0.2175" H 2775 5725 50  0001 C CNN "Standard Price"
F 6 "https://www.digikey.com/product-detail/en/texas-instruments/OPT3001DNPR/296-40474-2-ND/5039362" H 2775 5725 50  0001 C CNN "Link1"
F 7 "SENSOR OPT 550NM AMBIENT 6USON" H 2775 5725 50  0001 C CNN "Short Description"
F 8 "Texas Instruments" H 2775 5725 50  0001 C CNN "Vendor1"
F 9 "314020321" H 2775 5725 50  0001 C CNN "Seeed PN"
F 10 "OPT3001DNPR" H 2775 5725 50  0001 C CNN "MPN2"
F 11 "SMD Optical Sensor;UDFN-6" H 2775 5725 50  0001 C CNN "Seeed Description"
F 12 "TI" H 2775 5725 50  0001 C CNN "Vendor2"
	1    2775 5725
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 4575 2025 4575
Wire Wire Line
	2775 4575 2775 5325
Wire Wire Line
	6150 4725 6150 5125
Wire Wire Line
	6250 5125 6250 4725
Wire Wire Line
	6250 4725 6150 4725
Connection ~ 6150 4725
$Comp
L power:GND #PWR069
U 1 1 5E754485
P 6050 6275
F 0 "#PWR069" H 6050 6025 50  0001 C CNN
F 1 "GND" H 6050 6125 50  0000 C CNN
F 2 "" H 6050 6275 50  0001 C CNN
F 3 "" H 6050 6275 50  0001 C CNN
	1    6050 6275
	1    0    0    -1  
$EndComp
Wire Wire Line
	6050 6125 6050 6225
Wire Wire Line
	6050 6225 6150 6225
Wire Wire Line
	6250 6225 6250 6125
Connection ~ 6050 6225
Wire Wire Line
	6050 6225 6050 6275
Wire Wire Line
	6150 6125 6150 6225
Connection ~ 6150 6225
Wire Wire Line
	1950 5625 2375 5625
Text GLabel 1950 5825 0    50   Input ~ 0
SCL
Text GLabel 1950 5625 0    50   Input ~ 0
SDA
Wire Wire Line
	1950 5825 2375 5825
$Comp
L power:GND #PWR062
U 1 1 5E75BD95
P 2775 6275
F 0 "#PWR062" H 2775 6025 50  0001 C CNN
F 1 "GND" H 2775 6125 50  0000 C CNN
F 2 "" H 2775 6275 50  0001 C CNN
F 3 "" H 2775 6275 50  0001 C CNN
	1    2775 6275
	1    0    0    -1  
$EndComp
Wire Wire Line
	2775 6125 2775 6275
Text GLabel 5025 5725 0    50   Input ~ 0
SCL
Text GLabel 5025 5525 0    50   Input ~ 0
SDA
Wire Wire Line
	5025 5525 5750 5525
Wire Wire Line
	5025 5725 5750 5725
Wire Wire Line
	5750 5625 5675 5625
Wire Wire Line
	5300 5625 5300 5975
$Comp
L power:GND #PWR067
U 1 1 5E7679A5
P 5300 5975
F 0 "#PWR067" H 5300 5725 50  0001 C CNN
F 1 "GND" H 5300 5825 50  0000 C CNN
F 2 "" H 5300 5975 50  0001 C CNN
F 3 "" H 5300 5975 50  0001 C CNN
	1    5300 5975
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5E76DB8C
P 4700 3450
AR Path="/5D062750/5E76DB8C" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5E76DB8C" Ref="R51"  Part="1" 
F 0 "R51" V 4650 3225 50  0000 L CNN
F 1 "0" V 4700 3425 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 4630 3450 50  0001 C CNN
F 3 "~" H 4700 3450 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 4700 3450 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 4700 3450 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 4700 3450 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 4700 3450 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 4700 3450 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 4700 3450 50  0001 C CNN "Short Description"
F 10 "301010000" H 4700 3450 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 4700 3450 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 4700 3450 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 4700 3450 50  0001 C CNN "Vendor2"
	1    4700 3450
	0    1    1    0   
$EndComp
Wire Wire Line
	4550 3450 4250 3450
$Comp
L Device:R R?
U 1 1 5E771A45
P 5525 5625
AR Path="/5D062750/5E771A45" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5E771A45" Ref="R54"  Part="1" 
F 0 "R54" V 5475 5400 50  0000 L CNN
F 1 "0" V 5525 5600 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5455 5625 50  0001 C CNN
F 3 "~" H 5525 5625 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 5525 5625 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 5525 5625 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 5525 5625 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 5525 5625 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 5525 5625 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 5525 5625 50  0001 C CNN "Short Description"
F 10 "301010000" H 5525 5625 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 5525 5625 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 5525 5625 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 5525 5625 50  0001 C CNN "Vendor2"
	1    5525 5625
	0    1    1    0   
$EndComp
Wire Wire Line
	5375 5625 5300 5625
Text GLabel 7250 5525 2    50   Input ~ 0
INT_LIS2DE12_1
Wire Wire Line
	6650 5925 6775 5925
Wire Wire Line
	6775 5925 6775 6225
Wire Wire Line
	6150 6225 6250 6225
Connection ~ 6250 6225
Wire Wire Line
	6250 6225 6775 6225
Text GLabel 4400 4725 0    50   Input ~ 0
3V3
Text GLabel 3200 2100 0    50   Input ~ 0
3V3
Text GLabel 1900 4575 0    50   Input ~ 0
3V3
Text GLabel 4475 3300 0    50   Input ~ 0
INT_HDC2010
$Comp
L Device:R R?
U 1 1 5E4E359C
P 3475 5825
AR Path="/5D062750/5E4E359C" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5E4E359C" Ref="R48"  Part="1" 
F 0 "R48" V 3550 5500 50  0000 L CNN
F 1 "0" V 3475 5800 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3405 5825 50  0001 C CNN
F 3 "~" H 3475 5825 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 3475 5825 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 3475 5825 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 3475 5825 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 3475 5825 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 3475 5825 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 3475 5825 50  0001 C CNN "Short Description"
F 10 "301010000" H 3475 5825 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 3475 5825 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 3475 5825 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 3475 5825 50  0001 C CNN "Vendor2"
	1    3475 5825
	0    1    1    0   
$EndComp
Wire Wire Line
	3175 5825 3325 5825
Wire Wire Line
	3700 5825 3700 6125
Wire Wire Line
	3625 5825 3700 5825
$Comp
L power:GND #PWR064
U 1 1 5E4E591F
P 3700 6125
F 0 "#PWR064" H 3700 5875 50  0001 C CNN
F 1 "GND" H 3700 5975 50  0000 C CNN
F 2 "" H 3700 6125 50  0001 C CNN
F 3 "" H 3700 6125 50  0001 C CNN
	1    3700 6125
	1    0    0    -1  
$EndComp
Text GLabel 4000 5625 2    50   Input ~ 0
INT_SENSOR
$Comp
L Device:R R?
U 1 1 5F5FF654
P 5250 5125
AR Path="/5D062750/5F5FF654" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5F5FF654" Ref="R53"  Part="1" 
F 0 "R53" H 5320 5171 50  0000 L CNN
F 1 "2.21K" H 5320 5080 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 5180 5125 50  0001 C CNN
F 3 "~" H 5250 5125 50  0001 C CNN
F 4 "RES SMD 2.21K OHM 1% 1/10W 0402" H 5250 5125 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/ERJ-2RKF2211X/P2.21KLTR-ND/192198" H 5250 5125 50  0001 C CNN "Link1"
F 6 "ERJ-2RKF2211X" H 5250 5125 50  0001 C CNN "MPN1"
F 7 "0.00498" H 5250 5125 50  0001 C CNN "Standard Price"
F 8 "Panasonic Electronic Components" H 5250 5125 50  0001 C CNN "Vendor1"
F 9 "RES SMD 2.21K OHM 1% 1/10W 0402" H 5250 5125 50  0001 C CNN "Short Description"
F 10 "301010881" H 5250 5125 50  0001 C CNN "Seeed PN"
F 11 "RC0402FR-072K21L" H 5250 5125 50  0001 C CNN "MPN2"
F 12 "SMD RES 2.21K-1%-1/16W;0402" H 5250 5125 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 5250 5125 50  0001 C CNN "Vendor2"
	1    5250 5125
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 5425 5250 5425
Wire Wire Line
	5250 5425 5250 5275
Wire Wire Line
	5250 4975 5250 4725
Connection ~ 5250 4725
Wire Wire Line
	5250 4725 6150 4725
Wire Wire Line
	3200 2100 3450 2100
$Comp
L Device:C C?
U 1 1 5F2FEA4B
P 3450 2425
AR Path="/5D062750/5F2FEA4B" Ref="C?"  Part="1" 
AR Path="/5E6C68DD/5F2FEA4B" Ref="C41"  Part="1" 
F 0 "C41" H 3335 2379 50  0000 R CNN
F 1 "0.1U" H 3335 2470 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3488 2275 50  0001 C CNN
F 3 "~" H 3450 2425 50  0001 C CNN
F 4 "CAP CER 0.1UF 10V X5R 0402" H 3450 2425 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/samsung-electro-mechanics/CL05A104MP5NNNC/1276-1443-1-ND/3889529" H 3450 2425 50  0001 C CNN "Link1"
F 6 "CL05A104MP5NNNC" H 3450 2425 50  0001 C CNN "MPN1"
F 7 "$0.00315" H 3450 2425 50  0001 C CNN "Standard Price"
F 8 "Samsung Electro-Mechanics" H 3450 2425 50  0001 C CNN "Vendor1"
F 9 "CAP CER 0.1UF 10V X5R 0402" H 3450 2425 50  0001 C CNN "Short Description"
F 10 "302011121" H 3450 2425 50  0001 C CNN "Seeed PN"
F 11 "CC0402KRX5R6BB104" H 3450 2425 50  0001 C CNN "MPN2"
F 12 "YAGEO" H 3450 2425 50  0001 C CNN "Vendor2"
F 13 "SMD CAP Ceramic 100nF-10V-10%-X5R;0402" H 3450 2425 50  0001 C CNN "Seeed Description"
	1    3450 2425
	-1   0    0    1   
$EndComp
Wire Wire Line
	3450 2100 3450 2275
Wire Wire Line
	3450 2575 3450 2750
$Comp
L power:GND #PWR?
U 1 1 5F2FEA53
P 3450 2750
AR Path="/5D062750/5F2FEA53" Ref="#PWR?"  Part="1" 
AR Path="/5E6C68DD/5F2FEA53" Ref="#PWR063"  Part="1" 
F 0 "#PWR063" H 3450 2500 50  0001 C CNN
F 1 "GND" H 3455 2577 50  0000 C CNN
F 2 "" H 3450 2750 50  0001 C CNN
F 3 "" H 3450 2750 50  0001 C CNN
	1    3450 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E6D75A5
P 2025 5175
AR Path="/5D062750/5E6D75A5" Ref="#PWR?"  Part="1" 
AR Path="/5E6C68DD/5E6D75A5" Ref="#PWR061"  Part="1" 
F 0 "#PWR061" H 2025 4925 50  0001 C CNN
F 1 "GND" H 2030 5002 50  0000 C CNN
F 2 "" H 2025 5175 50  0001 C CNN
F 3 "" H 2025 5175 50  0001 C CNN
	1    2025 5175
	1    0    0    -1  
$EndComp
Wire Wire Line
	2025 5125 2025 5175
Wire Wire Line
	2025 4575 2025 4825
$Comp
L Device:C C?
U 1 1 5E6D759A
P 2025 4975
AR Path="/5D062750/5E6D759A" Ref="C?"  Part="1" 
AR Path="/5E6C68DD/5E6D759A" Ref="C40"  Part="1" 
F 0 "C40" H 1910 4929 50  0000 R CNN
F 1 "0.1U" H 1910 5020 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2063 4825 50  0001 C CNN
F 3 "~" H 2025 4975 50  0001 C CNN
F 4 "CAP CER 0.1UF 10V X5R 0402" H 2025 4975 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/samsung-electro-mechanics/CL05A104MP5NNNC/1276-1443-1-ND/3889529" H 2025 4975 50  0001 C CNN "Link1"
F 6 "CL05A104MP5NNNC" H 2025 4975 50  0001 C CNN "MPN1"
F 7 "$0.00315" H 2025 4975 50  0001 C CNN "Standard Price"
F 8 "Samsung Electro-Mechanics" H 2025 4975 50  0001 C CNN "Vendor1"
F 9 "CAP CER 0.1UF 10V X5R 0402" H 2025 4975 50  0001 C CNN "Short Description"
F 10 "302011121" H 2025 4975 50  0001 C CNN "Seeed PN"
F 11 "CC0402KRX5R6BB104" H 2025 4975 50  0001 C CNN "MPN2"
F 12 "YAGEO" H 2025 4975 50  0001 C CNN "Vendor2"
F 13 "SMD CAP Ceramic 100nF-10V-10%-X5R;0402" H 2025 4975 50  0001 C CNN "Seeed Description"
	1    2025 4975
	-1   0    0    1   
$EndComp
Connection ~ 3450 2100
Wire Wire Line
	3450 2100 4550 2100
Wire Wire Line
	4400 4725 4600 4725
Connection ~ 2025 4575
Wire Wire Line
	2025 4575 2775 4575
$Comp
L Device:C C?
U 1 1 5F31A5DF
P 4600 4925
AR Path="/5D062750/5F31A5DF" Ref="C?"  Part="1" 
AR Path="/5E6C68DD/5F31A5DF" Ref="C42"  Part="1" 
F 0 "C42" H 4485 4879 50  0000 R CNN
F 1 "0.1U" H 4485 4970 50  0000 R CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 4638 4775 50  0001 C CNN
F 3 "~" H 4600 4925 50  0001 C CNN
F 4 "CAP CER 0.1UF 10V X5R 0402" H 4600 4925 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/samsung-electro-mechanics/CL05A104MP5NNNC/1276-1443-1-ND/3889529" H 4600 4925 50  0001 C CNN "Link1"
F 6 "CL05A104MP5NNNC" H 4600 4925 50  0001 C CNN "MPN1"
F 7 "$0.00315" H 4600 4925 50  0001 C CNN "Standard Price"
F 8 "Samsung Electro-Mechanics" H 4600 4925 50  0001 C CNN "Vendor1"
F 9 "CAP CER 0.1UF 10V X5R 0402" H 4600 4925 50  0001 C CNN "Short Description"
F 10 "302011121" H 4600 4925 50  0001 C CNN "Seeed PN"
F 11 "CC0402KRX5R6BB104" H 4600 4925 50  0001 C CNN "MPN2"
F 12 "YAGEO" H 4600 4925 50  0001 C CNN "Vendor2"
F 13 "SMD CAP Ceramic 100nF-10V-10%-X5R;0402" H 4600 4925 50  0001 C CNN "Seeed Description"
	1    4600 4925
	-1   0    0    1   
$EndComp
Wire Wire Line
	4600 4725 4600 4775
Wire Wire Line
	4600 5075 4600 5150
$Comp
L power:GND #PWR?
U 1 1 5F31A5E7
P 4600 5150
AR Path="/5D062750/5F31A5E7" Ref="#PWR?"  Part="1" 
AR Path="/5E6C68DD/5F31A5E7" Ref="#PWR066"  Part="1" 
F 0 "#PWR066" H 4600 4900 50  0001 C CNN
F 1 "GND" H 4605 4977 50  0000 C CNN
F 2 "" H 4600 5150 50  0001 C CNN
F 3 "" H 4600 5150 50  0001 C CNN
	1    4600 5150
	1    0    0    -1  
$EndComp
Connection ~ 4600 4725
Wire Wire Line
	4600 4725 5250 4725
NoConn ~ 6650 5625
Text GLabel 7975 3000 0    50   Input ~ 0
INT_HDC2010
Text GLabel 8000 3250 0    50   Input ~ 0
INT_LIS2DE12_1
Wire Wire Line
	8000 3250 8325 3250
Wire Wire Line
	7975 3000 8325 3000
Wire Wire Line
	9000 3000 9000 3250
Connection ~ 9000 3250
Wire Wire Line
	9000 3250 9250 3250
$Comp
L Device:R R?
U 1 1 5F544388
P 9250 2850
AR Path="/5D062750/5F544388" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5F544388" Ref="R7"  Part="1" 
F 0 "R7" H 9320 2896 50  0000 L CNN
F 1 "2.21K" H 9320 2805 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9180 2850 50  0001 C CNN
F 3 "~" H 9250 2850 50  0001 C CNN
F 4 "RES SMD 2.21K OHM 1% 1/10W 0402" H 9250 2850 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/ERJ-2RKF2211X/P2.21KLTR-ND/192198" H 9250 2850 50  0001 C CNN "Link1"
F 6 "ERJ-2RKF2211X" H 9250 2850 50  0001 C CNN "MPN1"
F 7 "0.00498" H 9250 2850 50  0001 C CNN "Standard Price"
F 8 "Panasonic Electronic Components" H 9250 2850 50  0001 C CNN "Vendor1"
F 9 "RES SMD 2.21K OHM 1% 1/10W 0402" H 9250 2850 50  0001 C CNN "Short Description"
F 10 "301010881" H 9250 2850 50  0001 C CNN "Seeed PN"
F 11 "RC0402FR-072K21L" H 9250 2850 50  0001 C CNN "MPN2"
F 12 "SMD RES 2.21K-1%-1/16W;0402" H 9250 2850 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 9250 2850 50  0001 C CNN "Vendor2"
	1    9250 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 3000 9250 3250
Connection ~ 9250 3250
Wire Wire Line
	9250 3250 9625 3250
Text GLabel 8725 2500 0    50   Input ~ 0
3V3
Wire Wire Line
	8725 2500 9250 2500
Wire Wire Line
	9250 2500 9250 2700
Wire Wire Line
	4475 3300 4925 3300
Wire Wire Line
	3175 5625 3325 5625
Wire Wire Line
	6650 5525 7250 5525
$Comp
L Diode:BAT54XV2 D12
U 1 1 5F558404
P 8475 3000
F 0 "D12" H 8350 3125 50  0000 C CNN
F 1 "BAT54XV2" H 8700 3125 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-523" H 8475 2825 50  0001 C CNN
F 3 "https://www.onsemi.com/pub/Collateral/BAT54XV2T1-D.PDF" H 8475 3000 50  0001 C CNN
F 4 "BAT54XV2T1G" H 8475 3000 50  0001 C CNN "MPN2"
F 5 "SMD DIODE SCHOTTKY 30V-200MA;SOD523" H 8475 3000 50  0001 C CNN "Seeed Description"
F 6 "304020722" H 8475 3000 50  0001 C CNN "Seeed PN"
F 7 "ON" H 8475 3000 50  0001 C CNN "Vendor2"
	1    8475 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8625 3000 9000 3000
Wire Wire Line
	8625 3250 9000 3250
$Comp
L Diode:BAT54XV2 D13
U 1 1 5F5592EE
P 8475 3250
F 0 "D13" H 8350 3375 50  0000 C CNN
F 1 "BAT54XV2" H 8700 3375 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-523" H 8475 3075 50  0001 C CNN
F 3 "https://www.onsemi.com/pub/Collateral/BAT54XV2T1-D.PDF" H 8475 3250 50  0001 C CNN
F 4 "BAT54XV2T1G" H 8475 3250 50  0001 C CNN "MPN2"
F 5 "SMD DIODE SCHOTTKY 30V-200MA;SOD523" H 8475 3250 50  0001 C CNN "Seeed Description"
F 6 "304020722" H 8475 3250 50  0001 C CNN "Seeed PN"
F 7 "ON" H 8475 3250 50  0001 C CNN "Vendor2"
	1    8475 3250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5F4F8114
P 3475 5625
AR Path="/5D062750/5F4F8114" Ref="R?"  Part="1" 
AR Path="/5E6C68DD/5F4F8114" Ref="R49"  Part="1" 
F 0 "R49" V 3550 5300 50  0000 L CNN
F 1 "0" V 3475 5600 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 3405 5625 50  0001 C CNN
F 3 "~" H 3475 5625 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 3475 5625 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 3475 5625 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 3475 5625 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 3475 5625 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 3475 5625 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 3475 5625 50  0001 C CNN "Short Description"
F 10 "301010000" H 3475 5625 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 3475 5625 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 3475 5625 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 3475 5625 50  0001 C CNN "Vendor2"
	1    3475 5625
	0    1    1    0   
$EndComp
Wire Wire Line
	3625 5625 4000 5625
$EndSCHEMATC