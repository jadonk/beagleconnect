EESchema Schematic File Version 4
LIBS:LeashPCB-cache
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 4 10
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
L Connector_Generic:Conn_02x03_Odd_Even J?
U 1 1 5D08E152
P 8825 4675
AR Path="/5D08E152" Ref="J?"  Part="1" 
AR Path="/5D062DFA/5D08E152" Ref="J601"  Part="1" 
F 0 "J601" H 8875 4992 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 8875 4901 50  0000 C CNN
F 2 "leash:Tag-Connect" H 8825 4675 50  0001 C CNN
F 3 "~" H 8825 4675 50  0001 C CNN
F 4 "0" H 8825 4675 50  0001 C CNN "Standard Price"
	1    8825 4675
	1    0    0    -1  
$EndComp
Text Label 7425 4425 0    50   ~ 0
3V3
Wire Wire Line
	8375 5075 7725 5075
$Comp
L power:GND #PWR?
U 1 1 5D08E15A
P 7725 5275
AR Path="/5D08E15A" Ref="#PWR?"  Part="1" 
AR Path="/5D062DFA/5D08E15A" Ref="#PWR0601"  Part="1" 
F 0 "#PWR0601" H 7725 5025 50  0001 C CNN
F 1 "GND" H 7730 5102 50  0000 C CNN
F 2 "" H 7725 5275 50  0001 C CNN
F 3 "" H 7725 5275 50  0001 C CNN
	1    7725 5275
	1    0    0    -1  
$EndComp
Wire Wire Line
	7725 5275 7725 5075
$Comp
L Device:C C?
U 1 1 5D08E161
P 7725 4875
AR Path="/5D08E161" Ref="C?"  Part="1" 
AR Path="/5D062DFA/5D08E161" Ref="C601"  Part="1" 
F 0 "C601" H 7840 4921 50  0000 L CNN
F 1 "C" H 7840 4830 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7763 4725 50  0001 C CNN
F 3 "~" H 7725 4875 50  0001 C CNN
	1    7725 4875
	1    0    0    -1  
$EndComp
Wire Wire Line
	7725 5075 7725 5025
Connection ~ 7725 5075
Wire Wire Line
	7725 4575 7725 4725
Wire Wire Line
	7725 4575 7725 4425
Wire Wire Line
	7725 4425 7425 4425
Connection ~ 7725 4575
Wire Wire Line
	7725 4575 8625 4575
Wire Wire Line
	8375 5075 8375 4775
Wire Wire Line
	8375 4775 8625 4775
Wire Wire Line
	8625 4675 8075 4675
Text Label 8075 4675 0    50   ~ 0
~RESET
Wire Wire Line
	9125 4575 9725 4575
Wire Wire Line
	9125 4675 9725 4675
Wire Wire Line
	9125 4775 9725 4775
Text Label 9725 4575 2    50   ~ 0
TMS
Text Label 9725 4675 2    50   ~ 0
TCK
Text Label 9725 4775 2    50   ~ 0
TDO
$EndSCHEMATC
