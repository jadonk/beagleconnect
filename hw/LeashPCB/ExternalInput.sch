EESchema Schematic File Version 4
LIBS:LeashPCB-cache
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 3 10
Title "BeagleDust Leash PCB"
Date "2019-07-22"
Rev "1"
Comp "Beagleboard.org"
Comment1 "Schematic designed by Analog Life, LLC"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:Conn_01x02_Male J?
U 1 1 5D080251
P 7500 4725
AR Path="/5D080251" Ref="J?"  Part="1" 
AR Path="/5D0603E8/5D080251" Ref="J301"  Part="1" 
F 0 "J301" H 7608 4906 50  0000 C CNN
F 1 "Conn_01x02_Male" H 7608 4815 50  0000 C CNN
F 2 "Connector_JST:JST_PH_S2B-PH-SM4-TB_1x02-1MP_P2.00mm_Horizontal" H 7500 4725 50  0001 C CNN
F 3 "~" H 7500 4725 50  0001 C CNN
F 4 "0.03" H 7500 4725 50  0001 C CNN "Standard Price"
F 5 "https://lcsc.com/product-detail/Wire-To-Board-Wire-To-Wire-Connector_Boom-Precision-Elec-PH2-0-2PWB-2P-pitch2-0mm-Horizontal_C47647.html" H 7500 4725 50  0001 C CNN "Link1"
	1    7500 4725
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 4825 8000 4825
$Comp
L power:GND #PWR?
U 1 1 5D080259
P 8000 5175
AR Path="/5D080259" Ref="#PWR?"  Part="1" 
AR Path="/5D0603E8/5D080259" Ref="#PWR0301"  Part="1" 
F 0 "#PWR0301" H 8000 4925 50  0001 C CNN
F 1 "GND" H 8005 5002 50  0000 C CNN
F 2 "" H 8000 5175 50  0001 C CNN
F 3 "" H 8000 5175 50  0001 C CNN
	1    8000 5175
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 4825 8000 5175
Wire Wire Line
	7700 4725 8000 4725
Wire Wire Line
	8900 4725 9600 4725
Text HLabel 9600 4725 2    118  Input ~ 0
V_ALT
Text Label 8200 4725 0    50   ~ 0
ALT_IN
$Comp
L Device:D_Schottky D301
U 1 1 5D0807BE
P 8750 4725
F 0 "D301" H 8750 4500 50  0000 C CNN
F 1 "BAT54" H 8750 4591 50  0000 C CNN
F 2 "Diode_SMD:D_SOD-123" H 8750 4550 50  0001 C CNN
F 3 "" H 8750 4725 50  0001 C CNN
	1    8750 4725
	-1   0    0    1   
$EndComp
Text GLabel 8150 4350 2    50   Input ~ 0
ALT_IN
Wire Wire Line
	8150 4350 8000 4350
Wire Wire Line
	8000 4350 8000 4725
Connection ~ 8000 4725
Wire Wire Line
	8000 4725 8600 4725
Text Notes 8425 5025 0    50   ~ 0
No pop if using the \nswitch/jumper method
$EndSCHEMATC
