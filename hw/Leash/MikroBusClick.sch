EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 7 10
Title "BeagleConnect Leash"
Date "2020-08-31"
Rev "A"
Comp "Beagleboard.org"
Comment1 "Schematic originally designed by Analog Life, LLC"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	8125 4375 7900 4375
Wire Wire Line
	7900 4375 7900 4475
$Comp
L power:GND #PWR031
U 1 1 5D1F9F78
P 7900 4475
F 0 "#PWR031" H 7900 4225 50  0001 C CNN
F 1 "GND" H 7905 4302 50  0000 C CNN
F 2 "" H 7900 4475 50  0001 C CNN
F 3 "" H 7900 4475 50  0001 C CNN
	1    7900 4475
	1    0    0    -1  
$EndComp
Wire Wire Line
	9275 4275 10050 4275
$Comp
L power:GND #PWR033
U 1 1 5D200D92
P 9500 4525
F 0 "#PWR033" H 9500 4275 50  0001 C CNN
F 1 "GND" H 9505 4352 50  0000 C CNN
F 2 "" H 9500 4525 50  0001 C CNN
F 3 "" H 9500 4525 50  0001 C CNN
	1    9500 4525
	1    0    0    -1  
$EndComp
Wire Wire Line
	9500 4375 9275 4375
Wire Wire Line
	9500 4375 9500 4525
Wire Wire Line
	10050 3675 9275 3675
Wire Wire Line
	10050 3775 9275 3775
Wire Wire Line
	9275 3875 10050 3875
Wire Wire Line
	10050 3975 9275 3975
Wire Wire Line
	9275 4075 10050 4075
Wire Wire Line
	10050 4175 9275 4175
$Comp
L LeashPCB:mikroBUS-LeashPCB J?
U 1 1 5E8910E4
P 8725 5650
AR Path="/5E8910E4" Ref="J?"  Part="1" 
AR Path="/5D066680/5E8910E4" Ref="J5"  Part="1" 
F 0 "J5" H 8750 6365 50  0000 C CNN
F 1 "mikroBUS" H 8750 6274 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 8525 5850 50  0001 C CNN
F 3 "" H 8525 5850 50  0001 C CNN
F 4 "0.10" H 8725 5650 50  0001 C CNN "Standard Price"
F 5 "N/A" H 8725 5650 50  0001 C CNN "Description"
F 6 "https://SZconnect.com" H 8725 5650 50  0001 C CNN "Link1"
F 7 "ST-FH-254-0144-B" H 8725 5650 50  0001 C CNN "MPN1"
F 8 "Sinotop Electronics Ltd" H 8725 5650 50  0001 C CNN "Vendor1"
F 9 "CONN HDR 8POS 0.1 TIN SMD" H 8725 5650 50  0001 C CNN "Short Description"
F 10 "https://www.digikey.com/product-detail/en/sullins-connector-solutions/NPPC081KFXC-RC/S5639-ND/776098" H 8725 5650 50  0001 C CNN "Link2"
F 11 "ST-FH-254" H 8725 5650 50  0001 C CNN "MPN2"
F 12 "Need to buy in pairs!" H 8725 5650 50  0001 C CNN "Value modifier"
F 13 "Seeed Studio" H 8725 5650 50  0001 C CNN "Vendor2"
F 14 "SMD Black Female Header;1*8P-2.54-7.1mm（右前左后）" H 8725 5650 50  0001 C CNN "Seeed Description"
F 15 "320030864" H 8725 5650 50  0001 C CNN "Seeed PN"
	1    8725 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	8175 6000 7950 6000
Wire Wire Line
	7950 6000 7950 6100
$Comp
L power:GND #PWR032
U 1 1 5E8910FE
P 7950 6100
F 0 "#PWR032" H 7950 5850 50  0001 C CNN
F 1 "GND" H 7955 5927 50  0000 C CNN
F 2 "" H 7950 6100 50  0001 C CNN
F 3 "" H 7950 6100 50  0001 C CNN
	1    7950 6100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR034
U 1 1 5E89110F
P 9550 6150
F 0 "#PWR034" H 9550 5900 50  0001 C CNN
F 1 "GND" H 9555 5977 50  0000 C CNN
F 2 "" H 9550 6150 50  0001 C CNN
F 3 "" H 9550 6150 50  0001 C CNN
	1    9550 6150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 6000 9325 6000
Wire Wire Line
	9550 6000 9550 6150
Text GLabel 7125 3675 0    63   Input ~ 0
AN_MB1
Text GLabel 7125 3775 0    63   Input ~ 0
RST_MB1
Text GLabel 7125 3875 0    63   Input ~ 0
CS_MB1
Wire Wire Line
	7125 3675 8125 3675
Wire Wire Line
	7125 3775 8125 3775
Wire Wire Line
	7125 3875 8125 3875
Text GLabel 7125 3975 0    63   Input ~ 0
SCK
Text GLabel 7125 4075 0    63   Input ~ 0
MISO
Text GLabel 7125 4175 0    63   Input ~ 0
MOSI
Text GLabel 7125 4275 0    63   Input ~ 0
3V3
Wire Wire Line
	7125 3975 8125 3975
Wire Wire Line
	8125 4075 7125 4075
Wire Wire Line
	7125 4175 8125 4175
Wire Wire Line
	8125 4275 7125 4275
Text GLabel 10050 3675 2    63   Input ~ 0
PWM_MB1
Text GLabel 10050 3775 2    63   Input ~ 0
INT_MB1
Text GLabel 10050 3875 2    63   Input ~ 0
CC1352_TX_MB1_RX
Text GLabel 10050 3975 2    63   Input ~ 0
CC1352_RX_MB1_TX
Text GLabel 10050 4075 2    63   Input ~ 0
SCL
Text GLabel 10050 4175 2    63   Input ~ 0
SDA
Text GLabel 10050 4275 2    63   Input ~ 0
5V
Wire Wire Line
	9325 5900 10100 5900
Wire Wire Line
	10100 5300 9325 5300
Wire Wire Line
	10100 5400 9325 5400
Wire Wire Line
	9325 5500 10100 5500
Wire Wire Line
	10100 5600 9325 5600
Wire Wire Line
	9325 5700 10100 5700
Wire Wire Line
	10100 5800 9325 5800
Text GLabel 10100 5300 2    63   Input ~ 0
PWM_MB2
Text GLabel 10100 5400 2    63   Input ~ 0
INT_MB2
Text GLabel 10100 5500 2    63   Input ~ 0
CC1352_TX_MB2_RX
Text GLabel 10100 5600 2    63   Input ~ 0
CC1352_RX_MB2_TX
Text GLabel 10100 5700 2    63   Input ~ 0
SCL
Text GLabel 10100 5800 2    63   Input ~ 0
SDA
Text GLabel 10100 5900 2    63   Input ~ 0
5V
Text GLabel 7175 5300 0    63   Input ~ 0
AN_MB2
Text GLabel 7175 5400 0    63   Input ~ 0
RST_MB2
Text GLabel 7175 5500 0    63   Input ~ 0
CS_MB2
Wire Wire Line
	7175 5300 8175 5300
Wire Wire Line
	7175 5400 8175 5400
Wire Wire Line
	7175 5500 8175 5500
Text GLabel 7175 5600 0    63   Input ~ 0
SCK
Text GLabel 7175 5700 0    63   Input ~ 0
MISO
Text GLabel 7175 5800 0    63   Input ~ 0
MOSI
Text GLabel 7175 5900 0    63   Input ~ 0
3V3
Wire Wire Line
	7175 5600 8175 5600
Wire Wire Line
	8175 5700 7175 5700
Wire Wire Line
	7175 5800 8175 5800
Wire Wire Line
	8175 5900 7175 5900
$Comp
L LeashPCB:mikroBUS-LeashPCB J?
U 1 1 5D092D9C
P 8675 4025
AR Path="/5D092D9C" Ref="J?"  Part="1" 
AR Path="/5D066680/5D092D9C" Ref="J4"  Part="1" 
F 0 "J4" H 8700 4740 50  0000 C CNN
F 1 "mikroBUS" H 8700 4649 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 8475 4225 50  0001 C CNN
F 3 "" H 8475 4225 50  0001 C CNN
F 4 "0.10" H 8675 4025 50  0001 C CNN "Standard Price"
F 5 "Order 2 of these connectors! Right tight top" H 8675 4025 50  0001 C CNN "Description"
F 6 "https://SZconnect.com" H 8675 4025 50  0001 C CNN "Link1"
F 7 "ST-FH-254-0144-B" H 8675 4025 50  0001 C CNN "MPN1"
F 8 "Sinotop Electronics Ltd" H 8675 4025 50  0001 C CNN "Vendor1"
F 9 "CONN HDR 8POS 0.1 TIN SMD" H 8675 4025 50  0001 C CNN "Short Description"
F 10 "https://www.digikey.com/product-detail/en/sullins-connector-solutions/NPPC081KFXC-RC/S5639-ND/776098" H 8675 4025 50  0001 C CNN "Link2"
F 11 "ST-FH-254" H 8675 4025 50  0001 C CNN "MPN2"
F 12 "Need to buy in pairs!" H 8675 4025 50  0001 C CNN "Value modifier"
F 13 "Seeed Studio" H 8675 4025 50  0001 C CNN "Vendor2"
F 14 "SMD Black Female Header;1*8P-2.54-7.1mm（右前左后）" H 8675 4025 50  0001 C CNN "Seeed Description"
F 15 "320030864" H 8675 4025 50  0001 C CNN "Seeed PN"
	1    8675 4025
	1    0    0    -1  
$EndComp
$EndSCHEMATC
