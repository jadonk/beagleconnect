EESchema Schematic File Version 4
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LeashPCB:mikroBUS J?
U 1 1 5D092D9C
P 5900 2725
AR Path="/5D092D9C" Ref="J?"  Part="1" 
AR Path="/5D066680/5D092D9C" Ref="J702"  Part="1" 
F 0 "J702" H 5925 3440 50  0000 C CNN
F 1 "mikroBUS" H 5925 3349 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 5700 2925 50  0001 C CNN
F 3 "" H 5700 2925 50  0001 C CNN
F 4 "0" H 5900 2725 50  0001 C CNN "Standard Price"
	1    5900 2725
	1    0    0    -1  
$EndComp
$Comp
L LeashPCB:mikroBUS J?
U 1 1 5D092DA2
P 5900 4900
AR Path="/5D092DA2" Ref="J?"  Part="1" 
AR Path="/5D066680/5D092DA2" Ref="J701"  Part="1" 
F 0 "J701" H 5925 5615 50  0000 C CNN
F 1 "mikroBUS" H 5925 5524 50  0000 C CNN
F 2 "leash:MikroBus-SMD" H 5700 5100 50  0001 C CNN
F 3 "" H 5700 5100 50  0001 C CNN
F 4 "0" H 5900 4900 50  0001 C CNN "Standard Price"
	1    5900 4900
	1    0    0    -1  
$EndComp
Text HLabel 4600 2975 0    79   Input ~ 0
3V3
Text HLabel 7275 2975 2    79   Input ~ 0
5V
Text HLabel 4600 2375 0    79   Input ~ 0
AN_MB1
Text HLabel 4600 2475 0    79   Input ~ 0
RST
Text HLabel 4600 2575 0    79   Input ~ 0
CS_MB1
Text HLabel 4600 4750 0    79   Input ~ 0
CS_MB2
Text HLabel 4600 2675 0    79   Input ~ 0
SCK
Text HLabel 4600 2775 0    79   Input ~ 0
MISO
Text HLabel 4600 2875 0    79   Input ~ 0
MOSI
Text HLabel 7275 2375 2    79   Input ~ 0
PWM_MB1
Text HLabel 7450 4550 2    79   Input ~ 0
PWM_MB2
Text HLabel 7275 2475 2    79   Input ~ 0
INT_MB1
Text HLabel 7450 4650 2    79   Input ~ 0
INT_MB2
Text HLabel 7275 2575 2    79   Input ~ 0
MICRO_TX_MB1_RX
Text HLabel 7450 4750 2    79   Input ~ 0
MICRO_TX_MB2_RX
Text HLabel 7275 2675 2    79   Input ~ 0
MICRO_RX_MB1_TX
Text HLabel 7450 4850 2    79   Input ~ 0
MICRO_RX_MB2_TX
Text HLabel 7275 2875 2    79   Input ~ 0
SDA
Wire Wire Line
	5350 2975 4600 2975
Wire Wire Line
	5350 3075 5125 3075
Wire Wire Line
	5125 3075 5125 3175
$Comp
L power:GND #PWR0104
U 1 1 5D1F9F78
P 5125 3175
F 0 "#PWR0104" H 5125 2925 50  0001 C CNN
F 1 "GND" H 5130 3002 50  0000 C CNN
F 2 "" H 5125 3175 50  0001 C CNN
F 3 "" H 5125 3175 50  0001 C CNN
	1    5125 3175
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 2875 5350 2875
Wire Wire Line
	4600 2775 5350 2775
Wire Wire Line
	4600 2675 5350 2675
Wire Wire Line
	4600 2375 5350 2375
Wire Wire Line
	5350 2475 4600 2475
Wire Wire Line
	5350 2575 4600 2575
Wire Wire Line
	6500 2975 7275 2975
$Comp
L power:GND #PWR0105
U 1 1 5D200D92
P 6725 3225
F 0 "#PWR0105" H 6725 2975 50  0001 C CNN
F 1 "GND" H 6730 3052 50  0000 C CNN
F 2 "" H 6725 3225 50  0001 C CNN
F 3 "" H 6725 3225 50  0001 C CNN
	1    6725 3225
	1    0    0    -1  
$EndComp
Wire Wire Line
	6725 3075 6500 3075
Wire Wire Line
	6725 3075 6725 3225
Text HLabel 7275 2775 2    79   Input ~ 0
SCL
Wire Wire Line
	7275 2375 6500 2375
Wire Wire Line
	7275 2475 6500 2475
Wire Wire Line
	6500 2575 7275 2575
Wire Wire Line
	7275 2675 6500 2675
Wire Wire Line
	6500 2775 7275 2775
Wire Wire Line
	7275 2875 6500 2875
Wire Wire Line
	5350 4750 4600 4750
Wire Wire Line
	4600 4550 5350 4550
Text HLabel 4600 4550 0    79   Input ~ 0
AN_MB2
Text Label 4725 2475 0    50   ~ 0
RST
Text Label 4600 4650 0    50   ~ 0
RST
Wire Wire Line
	4600 4650 5350 4650
Text Label 4700 2675 0    50   ~ 0
SCK
Text Label 4700 2775 0    50   ~ 0
MISO
Text Label 4700 2875 0    50   ~ 0
MOSI
Text Label 4725 2975 0    50   ~ 0
3V3
Wire Wire Line
	5350 5150 4600 5150
Wire Wire Line
	4600 5050 5350 5050
Wire Wire Line
	4600 4950 5350 4950
Wire Wire Line
	4600 4850 5350 4850
Text Label 4600 4850 0    50   ~ 0
SCK
Text Label 4600 4950 0    50   ~ 0
MISO
Text Label 4600 5050 0    50   ~ 0
MOSI
Text Label 4600 5150 0    50   ~ 0
3V3
Wire Wire Line
	5350 5250 5125 5250
Wire Wire Line
	5125 5250 5125 5350
$Comp
L power:GND #PWR0106
U 1 1 5D217A46
P 5125 5350
F 0 "#PWR0106" H 5125 5100 50  0001 C CNN
F 1 "GND" H 5130 5177 50  0000 C CNN
F 2 "" H 5125 5350 50  0001 C CNN
F 3 "" H 5125 5350 50  0001 C CNN
	1    5125 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	6500 4550 7450 4550
Wire Wire Line
	7450 4650 6500 4650
Wire Wire Line
	6500 4750 7450 4750
Wire Wire Line
	7450 4850 6500 4850
Wire Wire Line
	6500 4950 7450 4950
Wire Wire Line
	6500 5050 7450 5050
Wire Wire Line
	6500 5150 7450 5150
$Comp
L power:GND #PWR0107
U 1 1 5D220EE5
P 6775 5400
F 0 "#PWR0107" H 6775 5150 50  0001 C CNN
F 1 "GND" H 6780 5227 50  0000 C CNN
F 2 "" H 6775 5400 50  0001 C CNN
F 3 "" H 6775 5400 50  0001 C CNN
	1    6775 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6775 5250 6775 5400
Wire Wire Line
	6500 5250 6775 5250
Text Label 7450 4950 2    50   ~ 0
SCL
Text Label 7450 5050 2    50   ~ 0
SCK
Text Label 7450 5150 2    50   ~ 0
5V
Text Label 7175 2975 2    50   ~ 0
5V
$EndSCHEMATC
