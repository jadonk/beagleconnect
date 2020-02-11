EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 3 9
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
L Device:C C?
U 1 1 5D08E161
P 7600 5400
AR Path="/5D08E161" Ref="C?"  Part="1" 
AR Path="/5D062DFA/5D08E161" Ref="C601"  Part="1" 
F 0 "C601" H 7715 5446 50  0000 L CNN
F 1 "0.1 uF" H 7715 5355 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 7638 5250 50  0001 C CNN
F 3 "~" H 7600 5400 50  0001 C CNN
F 4 "CAP CER 0.1UF 10V X5R 0402" H 7600 5400 50  0001 C CNN "Description"
F 5 "https://www.digikey.com/product-detail/en/samsung-electro-mechanics/CL05A104MP5NNNC/1276-1443-1-ND/3889529" H 7600 5400 50  0001 C CNN "Link1"
F 6 "CL05A104MP5NNNC" H 7600 5400 50  0001 C CNN "MPN1"
F 7 "$0.00315" H 7600 5400 50  0001 C CNN "Standard Price"
F 8 "Samsung Electro-Mechanics" H 7600 5400 50  0001 C CNN "Vendor1"
F 9 "CAP CER 0.1UF 10V X5R 0402" H 7600 5400 50  0001 C CNN "Short Description"
F 10 "+A1" H 7600 5400 50  0001 C CNN "Population"
	1    7600 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 5200 7600 5250
Connection ~ 7600 5200
Wire Wire Line
	7600 5200 8625 5200
Wire Wire Line
	9125 5200 9625 5200
Wire Wire Line
	8625 5300 8225 5300
Wire Wire Line
	9125 5600 9625 5600
$Comp
L power:+3V3 #PWR0110
U 1 1 5D46AF03
P 7600 5000
F 0 "#PWR0110" H 7600 4850 50  0001 C CNN
F 1 "+3V3" H 7615 5173 50  0000 C CNN
F 2 "" H 7600 5000 50  0001 C CNN
F 3 "" H 7600 5000 50  0001 C CNN
	1    7600 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 5000 7600 5200
$Comp
L Connector_Generic:Conn_02x05_Counter_Clockwise J401
U 1 1 5D471BC7
P 8825 5400
F 0 "J401" H 8875 5817 50  0000 C CNN
F 1 "TAG-CONNECT-10" H 8875 5726 50  0000 C CNN
F 2 "leash:Tag-Connect-10" H 8825 5400 50  0001 C CNN
F 3 "~" H 8825 5400 50  0001 C CNN
F 4 "N/A" H 8825 5400 50  0001 C CNN "Description"
F 5 "N/A" H 8825 5400 50  0001 C CNN "Link1"
F 6 "N/A" H 8825 5400 50  0001 C CNN "MPN1"
F 7 "+A1" H 8825 5400 50  0001 C CNN "Population"
F 8 "0" H 8825 5400 50  0001 C CNN "Standard Price"
F 9 "Tag Connect, Inc" H 8825 5400 50  0001 C CNN "Vendor1"
F 10 "N/A" H 8825 5400 50  0001 C CNN "Short Description"
	1    8825 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8625 5600 8500 5600
Wire Wire Line
	7600 5600 7600 5825
$Comp
L power:GND #PWR?
U 1 1 5D4C51BB
P 7600 5825
AR Path="/5D4C51BB" Ref="#PWR?"  Part="1" 
AR Path="/5D062DFA/5D4C51BB" Ref="#PWR0154"  Part="1" 
F 0 "#PWR0154" H 7600 5575 50  0001 C CNN
F 1 "GND" H 7605 5652 50  0000 C CNN
F 2 "" H 7600 5825 50  0001 C CNN
F 3 "" H 7600 5825 50  0001 C CNN
	1    7600 5825
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9125 5400 9625 5400
Wire Wire Line
	8625 5500 8225 5500
NoConn ~ 9125 5500
Wire Wire Line
	8625 5400 8500 5400
Wire Wire Line
	8500 5400 8500 5600
Connection ~ 8500 5600
Wire Wire Line
	8500 5600 7600 5600
Wire Wire Line
	7600 5550 7600 5600
Connection ~ 7600 5600
NoConn ~ 9125 5300
Text HLabel 9625 5400 2    50   Input ~ 0
TDI
Text HLabel 9625 5600 2    50   Input ~ 0
TDO
Text HLabel 9625 5200 2    50   Input ~ 0
~RESET
Text HLabel 8225 5300 0    50   Input ~ 0
TMS
Text HLabel 8225 5500 0    50   Input ~ 0
TCK
$EndSCHEMATC
