EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 3 11
Title "BeagleConnect Freedom"
Date "2020-11-03"
Rev "C4"
Comp "Beagleboard.org"
Comment1 "Schematic originally designed by Analog Life, LLC"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:C C?
U 1 1 5D08E161
P 7025 5400
AR Path="/5D08E161" Ref="C?"  Part="1" 
AR Path="/5D062DFA/5D08E161" Ref="C1"  Part="1" 
F 0 "C1" H 7140 5446 50  0000 L CNN
F 1 "0.1U" H 7140 5355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7063 5250 50  0001 C CNN
F 3 "~" H 7025 5400 50  0001 C CNN
F 4 "CAP CER 0.1UF 10V X5R 0402" H 7025 5400 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/samsung-electro-mechanics/CL05A104MP5NNNC/1276-1443-1-ND/3889529" H 7025 5400 50  0001 C CNN "Link1"
F 6 "CL05A104MP5NNNC" H 7025 5400 50  0001 C CNN "MPN1"
F 7 "$0.00315" H 7025 5400 50  0001 C CNN "Standard Price"
F 8 "Samsung Electro-Mechanics" H 7025 5400 50  0001 C CNN "Vendor1"
F 9 "CAP CER 0.1UF 10V X5R 0402" H 7025 5400 50  0001 C CNN "Short Description"
F 10 "" H 7025 5400 50  0001 C CNN "Population"
F 11 "302011121" H 7025 5400 50  0001 C CNN "Seeed PN"
F 12 "CC0402KRX5R6BB104" H 7025 5400 50  0001 C CNN "MPN2"
F 13 "YAGEO" H 7025 5400 50  0001 C CNN "Vendor2"
F 14 "SMD CAP Ceramic 100nF-10V-10%-X5R;0402" H 7025 5400 50  0001 C CNN "Seeed Description"
	1    7025 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7025 5200 7025 5250
Connection ~ 7025 5200
Wire Wire Line
	7025 5200 8625 5200
Wire Wire Line
	8625 5300 8225 5300
$Comp
L Connector_Generic:Conn_02x05_Counter_Clockwise J2
U 1 1 5D471BC7
P 8825 5400
F 0 "J2" H 8875 5817 50  0000 C CNN
F 1 "TAG-CONNECT-10" H 8875 5726 50  0000 C CNN
F 2 "leash:Tag-Connect-10" H 8825 5400 50  0001 C CNN
F 3 "~" H 8825 5400 50  0001 C CNN
F 4 "N/A" H 8825 5400 50  0001 C CNN "Description"
F 5 "N/A" H 8825 5400 50  0001 C CNN "Link1"
F 6 "N/A" H 8825 5400 50  0001 C CNN "MPN1"
F 7 "DNP" H 8825 5400 50  0001 C CNN "Population"
F 8 "0" H 8825 5400 50  0001 C CNN "Standard Price"
F 9 "Tag Connect, Inc" H 8825 5400 50  0001 C CNN "Vendor1"
F 10 "N/A" H 8825 5400 50  0001 C CNN "Short Description"
F 11 "0" H 8825 5400 50  0001 C CNN "Seeed PN"
	1    8825 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8625 5600 8500 5600
Wire Wire Line
	7025 5600 7025 5825
$Comp
L power:GND #PWR?
U 1 1 5D4C51BB
P 7025 5825
AR Path="/5D4C51BB" Ref="#PWR?"  Part="1" 
AR Path="/5D062DFA/5D4C51BB" Ref="#PWR03"  Part="1" 
F 0 "#PWR03" H 7025 5575 50  0001 C CNN
F 1 "GND" H 7030 5652 50  0000 C CNN
F 2 "" H 7025 5825 50  0001 C CNN
F 3 "" H 7025 5825 50  0001 C CNN
	1    7025 5825
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8625 5500 8225 5500
NoConn ~ 9125 5500
Wire Wire Line
	8625 5400 8500 5400
Wire Wire Line
	8500 5400 8500 5600
Connection ~ 8500 5600
Wire Wire Line
	8500 5600 7025 5600
Wire Wire Line
	7025 5550 7025 5600
Connection ~ 7025 5600
NoConn ~ 9125 5300
Text GLabel 9625 5200 2    63   Input ~ 0
RESET_N
Text GLabel 10300 5400 2    63   Input ~ 0
PWM_MB1
Text GLabel 8225 5300 0    63   Input ~ 0
CC1352_TMS
Text GLabel 8225 5500 0    63   Input ~ 0
CC1352_TCK
Wire Wire Line
	9125 5200 9625 5200
Text GLabel 10300 5600 2    63   Input ~ 0
INT_MB1
Text GLabel 6800 4950 0    63   Input ~ 0
3V3
Wire Wire Line
	6800 4950 7025 4950
Wire Wire Line
	7025 4950 7025 5200
$Comp
L Device:R R?
U 1 1 6171ADB7
P 9900 5600
AR Path="/5D062750/6171ADB7" Ref="R?"  Part="1" 
AR Path="/5D062DFA/6171ADB7" Ref="R29"  Part="1" 
F 0 "R29" V 9825 5425 50  0000 L CNN
F 1 "0" V 9900 5575 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9830 5600 50  0001 C CNN
F 3 "~" H 9900 5600 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 9900 5600 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 9900 5600 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 9900 5600 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 9900 5600 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 9900 5600 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 9900 5600 50  0001 C CNN "Short Description"
F 10 "301010000" H 9900 5600 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 9900 5600 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 9900 5600 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 9900 5600 50  0001 C CNN "Vendor2"
	1    9900 5600
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 6171ADC7
P 9900 5400
AR Path="/5D062750/6171ADC7" Ref="R?"  Part="1" 
AR Path="/5D062DFA/6171ADC7" Ref="R16"  Part="1" 
F 0 "R16" V 9825 5250 50  0000 L CNN
F 1 "0" V 9900 5375 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" V 9830 5400 50  0001 C CNN
F 3 "~" H 9900 5400 50  0001 C CNN
F 4 "RES 0 OHM JUMPER 1/16W 0402" H 9900 5400 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RMCF0402ZT0R00/RMCF0402ZT0R00TR-ND/1756905" H 9900 5400 50  0001 C CNN "Link1"
F 6 "RMCF0402ZT0R00" H 9900 5400 50  0001 C CNN "MPN1"
F 7 "$0.00127" H 9900 5400 50  0001 C CNN "Standard Price"
F 8 "Stackpole Electronics Inc" H 9900 5400 50  0001 C CNN "Vendor1"
F 9 "RES 0 OHM JUMPER 1/16W 0402" H 9900 5400 50  0001 C CNN "Short Description"
F 10 "301010000" H 9900 5400 50  0001 C CNN "Seeed PN"
F 11 "RC0402JR-070RL" H 9900 5400 50  0001 C CNN "MPN2"
F 12 "SMD RES 0R-5%-1/16W;0402" H 9900 5400 50  0001 C CNN "Seeed Description"
F 13 "YAGEO" H 9900 5400 50  0001 C CNN "Vendor2"
	1    9900 5400
	0    1    1    0   
$EndComp
Wire Wire Line
	9125 5400 9750 5400
Wire Wire Line
	9125 5600 9750 5600
Text Label 9200 5400 0    50   ~ 0
CC1352_TDI
Text Label 9200 5600 0    50   ~ 0
CC1352_TDO
Wire Wire Line
	10300 5400 10050 5400
Wire Wire Line
	10050 5600 10300 5600
$EndSCHEMATC