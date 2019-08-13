EESchema Schematic File Version 4
LIBS:LeashPCB-cache
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 9 10
Title "BeagleDust Leash PCB"
Date "2019-08-12"
Rev "A"
Comp "Beagleboard.org"
Comment1 "Schematic designed by Analog Life, LLC"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LeashPCB:mikroBUS J?
U 1 1 5D092D9C
P 8675 4025
AR Path="/5D092D9C" Ref="J?"  Part="1" 
AR Path="/5D066680/5D092D9C" Ref="J702"  Part="1" 
F 0 "J702" H 8700 4740 50  0000 C CNN
F 1 "mikroBUS" H 8700 4649 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 8475 4225 50  0001 C CNN
F 3 "" H 8475 4225 50  0001 C CNN
F 4 "0" H 8675 4025 50  0001 C CNN "Standard Price"
F 5 "N/A" H 8675 4025 50  0001 C CNN "Description"
F 6 "N/A" H 8675 4025 50  0001 C CNN "Link1"
F 7 "N/A" H 8675 4025 50  0001 C CNN "MPN1"
F 8 "DNP" H 8675 4025 50  0001 C CNN "Population"
F 9 "MikroElectronika" H 8675 4025 50  0001 C CNN "Vendor1"
F 10 "N/A" H 8675 4025 50  0001 C CNN "Short Description"
	1    8675 4025
	1    0    0    -1  
$EndComp
$Comp
L LeashPCB:mikroBUS J?
U 1 1 5D092DA2
P 8675 6200
AR Path="/5D092DA2" Ref="J?"  Part="1" 
AR Path="/5D066680/5D092DA2" Ref="J701"  Part="1" 
F 0 "J701" H 8700 6915 50  0000 C CNN
F 1 "mikroBUS" H 8700 6824 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 8475 6400 50  0001 C CNN
F 3 "" H 8475 6400 50  0001 C CNN
F 4 "0" H 8675 6200 50  0001 C CNN "Standard Price"
F 5 "N/A" H 8675 6200 50  0001 C CNN "Description"
F 6 "N/A" H 8675 6200 50  0001 C CNN "Link1"
F 7 "N/A" H 8675 6200 50  0001 C CNN "MPN1"
F 8 "DNP" H 8675 6200 50  0001 C CNN "Population"
F 9 "MikroElectronika" H 8675 6200 50  0001 C CNN "Vendor1"
F 10 "N/A" H 8675 6200 50  0001 C CNN "Short Description"
	1    8675 6200
	1    0    0    -1  
$EndComp
Text HLabel 7375 4275 0    79   Input ~ 0
3V3
Text HLabel 10050 4275 2    79   Input ~ 0
5V
Text HLabel 7375 3675 0    79   Input ~ 0
AN_MB1
Text HLabel 7375 3775 0    79   Input ~ 0
RST_MB1
Text HLabel 7375 3875 0    79   Input ~ 0
CS_MB1
Text HLabel 7375 6050 0    79   Input ~ 0
CS_MB2
Text HLabel 7375 3975 0    79   Input ~ 0
SCK
Text HLabel 7375 4075 0    79   Input ~ 0
MISO
Text HLabel 7375 4175 0    79   Input ~ 0
MOSI
Text HLabel 10050 3675 2    79   Input ~ 0
PWM_MB1
Text HLabel 10225 5850 2    79   Input ~ 0
PWM_MB2
Text HLabel 10050 3775 2    79   Input ~ 0
INT_MB1
Text HLabel 10225 5950 2    79   Input ~ 0
INT_MB2
Text HLabel 10050 3875 2    79   Input ~ 0
MICRO_TX_MB1_RX
Text HLabel 10225 6050 2    79   Input ~ 0
MICRO_TX_MB2_RX
Text HLabel 10050 3975 2    79   Input ~ 0
MICRO_RX_MB1_TX
Text HLabel 10225 6150 2    79   Input ~ 0
MICRO_RX_MB2_TX
Text HLabel 10050 4175 2    79   Input ~ 0
SDA
Wire Wire Line
	8125 4275 7375 4275
Wire Wire Line
	8125 4375 7900 4375
Wire Wire Line
	7900 4375 7900 4475
$Comp
L power:GND #PWR0104
U 1 1 5D1F9F78
P 7900 4475
F 0 "#PWR0104" H 7900 4225 50  0001 C CNN
F 1 "GND" H 7905 4302 50  0000 C CNN
F 2 "" H 7900 4475 50  0001 C CNN
F 3 "" H 7900 4475 50  0001 C CNN
	1    7900 4475
	1    0    0    -1  
$EndComp
Wire Wire Line
	7375 4175 8125 4175
Wire Wire Line
	7375 4075 8125 4075
Wire Wire Line
	7375 3975 8125 3975
Wire Wire Line
	7375 3675 8125 3675
Wire Wire Line
	8125 3775 7375 3775
Wire Wire Line
	8125 3875 7375 3875
Wire Wire Line
	9275 4275 10050 4275
$Comp
L power:GND #PWR0105
U 1 1 5D200D92
P 9500 4525
F 0 "#PWR0105" H 9500 4275 50  0001 C CNN
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
Text HLabel 10050 4075 2    79   Input ~ 0
SCL
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
Wire Wire Line
	8125 6050 7375 6050
Wire Wire Line
	7375 5850 8125 5850
Text HLabel 7375 5850 0    79   Input ~ 0
AN_MB2
Wire Wire Line
	7375 5950 8125 5950
Text Label 7475 3975 0    50   ~ 0
SCK
Text Label 7475 4075 0    50   ~ 0
MISO
Text Label 7475 4175 0    50   ~ 0
MOSI
Text Label 7500 4275 0    50   ~ 0
3V3
Wire Wire Line
	8125 6450 7375 6450
Wire Wire Line
	7375 6350 8125 6350
Wire Wire Line
	7375 6250 8125 6250
Wire Wire Line
	7375 6150 8125 6150
Text Label 7375 6150 0    50   ~ 0
SCK
Text Label 7375 6250 0    50   ~ 0
MISO
Text Label 7375 6350 0    50   ~ 0
MOSI
Text Label 7375 6450 0    50   ~ 0
3V3
Wire Wire Line
	8125 6550 7900 6550
Wire Wire Line
	7900 6550 7900 6650
$Comp
L power:GND #PWR0106
U 1 1 5D217A46
P 7900 6650
F 0 "#PWR0106" H 7900 6400 50  0001 C CNN
F 1 "GND" H 7905 6477 50  0000 C CNN
F 2 "" H 7900 6650 50  0001 C CNN
F 3 "" H 7900 6650 50  0001 C CNN
	1    7900 6650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9275 5850 10225 5850
Wire Wire Line
	10225 5950 9275 5950
Wire Wire Line
	9275 6050 10225 6050
Wire Wire Line
	10225 6150 9275 6150
Wire Wire Line
	9275 6250 10225 6250
Wire Wire Line
	9275 6350 10225 6350
Wire Wire Line
	9275 6450 10225 6450
$Comp
L power:GND #PWR0107
U 1 1 5D220EE5
P 9550 6700
F 0 "#PWR0107" H 9550 6450 50  0001 C CNN
F 1 "GND" H 9555 6527 50  0000 C CNN
F 2 "" H 9550 6700 50  0001 C CNN
F 3 "" H 9550 6700 50  0001 C CNN
	1    9550 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 6550 9550 6700
Wire Wire Line
	9275 6550 9550 6550
Text Label 10225 6250 2    50   ~ 0
SCL
Text Label 10225 6350 2    50   ~ 0
SCK
Text Label 10225 6450 2    50   ~ 0
5V
Text Label 9950 4275 2    50   ~ 0
5V
Text HLabel 7375 5950 0    79   Input ~ 0
RST_MB2
$EndSCHEMATC
