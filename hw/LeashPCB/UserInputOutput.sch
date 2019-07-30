EESchema Schematic File Version 4
LIBS:LeashPCB-cache
EELAYER 30 0
EELAYER END
$Descr B 17000 11000
encoding utf-8
Sheet 6 10
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
L Switch:SW_SPST SW2
U 1 1 5D565CF9
P 7900 4825
F 0 "SW2" H 7900 5060 50  0000 C CNN
F 1 "SW_SPST" H 7900 4969 50  0000 C CNN
F 2 "leash:EVQ-P7A01P" H 7900 4825 50  0001 C CNN
F 3 "https://b2b-api.panasonic.eu/file_stream/pids/fileversion/2431" H 7900 4825 50  0001 C CNN
F 4 "EVQ-P7A01P" H 7900 4825 50  0001 C CNN "MPN1"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/EVQ-P7A01P/P16763TR-ND/4429447" H 7900 4825 50  0001 C CNN "Link1"
	1    7900 4825
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5D565FA6
P 8200 5200
F 0 "#PWR0103" H 8200 4950 50  0001 C CNN
F 1 "GND" H 8205 5027 50  0000 C CNN
F 2 "" H 8200 5200 50  0001 C CNN
F 3 "" H 8200 5200 50  0001 C CNN
	1    8200 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 5200 8200 4825
Wire Wire Line
	8200 4825 8100 4825
Text HLabel 7450 4825 0    98   Input ~ 0
BTN1
Wire Wire Line
	7700 4825 7450 4825
$Comp
L Switch:SW_SPST SW1
U 1 1 5D568EA2
P 9500 4800
F 0 "SW1" H 9500 5035 50  0000 C CNN
F 1 "SW_SPST" H 9500 4944 50  0000 C CNN
F 2 "leash:EVQ-P7A01P" H 9500 4800 50  0001 C CNN
F 3 "https://b2b-api.panasonic.eu/file_stream/pids/fileversion/2431" H 9500 4800 50  0001 C CNN
F 4 "EVQ-P7A01P" H 9500 4800 50  0001 C CNN "MPN1"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/EVQ-P7A01P/P16763TR-ND/4429447" H 9500 4800 50  0001 C CNN "Link1"
	1    9500 4800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0153
U 1 1 5D568EAC
P 9800 5175
F 0 "#PWR0153" H 9800 4925 50  0001 C CNN
F 1 "GND" H 9805 5002 50  0000 C CNN
F 2 "" H 9800 5175 50  0001 C CNN
F 3 "" H 9800 5175 50  0001 C CNN
	1    9800 5175
	1    0    0    -1  
$EndComp
Wire Wire Line
	9800 5175 9800 4800
Wire Wire Line
	9800 4800 9700 4800
Text HLabel 9050 4800 0    98   Input ~ 0
BTN2
Wire Wire Line
	9300 4800 9050 4800
$EndSCHEMATC
