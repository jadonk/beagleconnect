EESchema Schematic File Version 4
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 10
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
L Connector:Conn_01x02_Male J?
U 1 1 5D080251
P 4450 3000
AR Path="/5D080251" Ref="J?"  Part="1" 
AR Path="/5D0603E8/5D080251" Ref="J301"  Part="1" 
F 0 "J301" H 4558 3181 50  0000 C CNN
F 1 "Conn_01x02_Male" H 4558 3090 50  0000 C CNN
F 2 "Connector_JST:JST_PH_S2B-PH-SM4-TB_1x02-1MP_P2.00mm_Horizontal" H 4450 3000 50  0001 C CNN
F 3 "~" H 4450 3000 50  0001 C CNN
F 4 "0.03" H 4450 3000 50  0001 C CNN "Standard Price"
F 5 "https://lcsc.com/product-detail/Wire-To-Board-Wire-To-Wire-Connector_Boom-Precision-Elec-PH2-0-2PWB-2P-pitch2-0mm-Horizontal_C47647.html" H 4450 3000 50  0001 C CNN "Link1"
	1    4450 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4650 3100 4950 3100
$Comp
L power:GND #PWR?
U 1 1 5D080259
P 4950 3450
AR Path="/5D080259" Ref="#PWR?"  Part="1" 
AR Path="/5D0603E8/5D080259" Ref="#PWR0301"  Part="1" 
F 0 "#PWR0301" H 4950 3200 50  0001 C CNN
F 1 "GND" H 4955 3277 50  0000 C CNN
F 2 "" H 4950 3450 50  0001 C CNN
F 3 "" H 4950 3450 50  0001 C CNN
	1    4950 3450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 3100 4950 3450
Wire Wire Line
	4650 3000 4950 3000
Wire Wire Line
	5850 3000 6550 3000
Text HLabel 6550 3000 2    118  Input ~ 0
V_ALT
Text Label 5150 3000 0    50   ~ 0
ALT_IN
$Comp
L Diode:BAT54W D301
U 1 1 5D0807BE
P 5700 3000
F 0 "D301" H 5700 2775 50  0000 C CNN
F 1 "BAT54" H 5700 2866 50  0000 C CNN
F 2 "" H 5700 2825 50  0001 C CNN
F 3 "" H 5700 3000 50  0001 C CNN
	1    5700 3000
	-1   0    0    1   
$EndComp
Text GLabel 5100 2625 2    50   Input ~ 0
ALT_IN
Wire Wire Line
	5100 2625 4950 2625
Wire Wire Line
	4950 2625 4950 3000
Connection ~ 4950 3000
Wire Wire Line
	4950 3000 5550 3000
Text Notes 5375 3300 0    50   ~ 0
No pop if using the \nswitch/jumper method
$EndSCHEMATC
