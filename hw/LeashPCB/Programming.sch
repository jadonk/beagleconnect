EESchema Schematic File Version 4
LIBS:LeashPCB-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 10
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
L Connector_Generic:Conn_02x03_Odd_Even J?
U 1 1 5D08E152
P 5700 3450
AR Path="/5D08E152" Ref="J?"  Part="1" 
AR Path="/5D062DFA/5D08E152" Ref="J601"  Part="1" 
F 0 "J601" H 5750 3767 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 5750 3676 50  0000 C CNN
F 2 "" H 5700 3450 50  0001 C CNN
F 3 "~" H 5700 3450 50  0001 C CNN
F 4 "0" H 5700 3450 50  0001 C CNN "Standard Price"
	1    5700 3450
	1    0    0    -1  
$EndComp
Text Label 4300 3200 0    50   ~ 0
3V3
Wire Wire Line
	5250 3850 4600 3850
$Comp
L power:GND #PWR?
U 1 1 5D08E15A
P 4600 4050
AR Path="/5D08E15A" Ref="#PWR?"  Part="1" 
AR Path="/5D062DFA/5D08E15A" Ref="#PWR0601"  Part="1" 
F 0 "#PWR0601" H 4600 3800 50  0001 C CNN
F 1 "GND" H 4605 3877 50  0000 C CNN
F 2 "" H 4600 4050 50  0001 C CNN
F 3 "" H 4600 4050 50  0001 C CNN
	1    4600 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 4050 4600 3850
$Comp
L Device:C C?
U 1 1 5D08E161
P 4600 3650
AR Path="/5D08E161" Ref="C?"  Part="1" 
AR Path="/5D062DFA/5D08E161" Ref="C601"  Part="1" 
F 0 "C601" H 4715 3696 50  0000 L CNN
F 1 "C" H 4715 3605 50  0000 L CNN
F 2 "" H 4638 3500 50  0001 C CNN
F 3 "~" H 4600 3650 50  0001 C CNN
	1    4600 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 3850 4600 3800
Connection ~ 4600 3850
Wire Wire Line
	4600 3350 4600 3500
Wire Wire Line
	4600 3350 4600 3200
Wire Wire Line
	4600 3200 4300 3200
Connection ~ 4600 3350
Wire Wire Line
	4600 3350 5500 3350
Wire Wire Line
	5250 3850 5250 3550
Wire Wire Line
	5250 3550 5500 3550
Wire Wire Line
	5500 3450 4950 3450
Text Label 4950 3450 0    50   ~ 0
~RESET
Wire Wire Line
	6000 3350 6600 3350
Wire Wire Line
	6000 3450 6600 3450
Wire Wire Line
	6000 3550 6600 3550
Text Label 6600 3350 2    50   ~ 0
TMS
Text Label 6600 3450 2    50   ~ 0
TCK
Text Label 6600 3550 2    50   ~ 0
TDO
$EndSCHEMATC
