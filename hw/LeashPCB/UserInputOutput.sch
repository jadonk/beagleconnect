EESchema Schematic File Version 4
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 10
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
L Switch:SW_SPST SW2
U 1 1 5D565CF9
P 4975 3275
F 0 "SW2" H 4975 3510 50  0000 C CNN
F 1 "SW_SPST" H 4975 3419 50  0000 C CNN
F 2 "leash:EVQ-P7A01P" H 4975 3275 50  0001 C CNN
F 3 "https://b2b-api.panasonic.eu/file_stream/pids/fileversion/2431" H 4975 3275 50  0001 C CNN
F 4 "EVQ-P7A01P" H 4975 3275 50  0001 C CNN "MPN1"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/EVQ-P7A01P/P16763TR-ND/4429447" H 4975 3275 50  0001 C CNN "Link1"
	1    4975 3275
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5D565FA6
P 5275 3650
F 0 "#PWR0103" H 5275 3400 50  0001 C CNN
F 1 "GND" H 5280 3477 50  0000 C CNN
F 2 "" H 5275 3650 50  0001 C CNN
F 3 "" H 5275 3650 50  0001 C CNN
	1    5275 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5275 3650 5275 3275
Wire Wire Line
	5275 3275 5175 3275
Text HLabel 4525 3275 0    98   Input ~ 0
BTN1
Wire Wire Line
	4775 3275 4525 3275
$Comp
L Switch:SW_SPST SW1
U 1 1 5D568EA2
P 6575 3250
F 0 "SW1" H 6575 3485 50  0000 C CNN
F 1 "SW_SPST" H 6575 3394 50  0000 C CNN
F 2 "leash:EVQ-P7A01P" H 6575 3250 50  0001 C CNN
F 3 "https://b2b-api.panasonic.eu/file_stream/pids/fileversion/2431" H 6575 3250 50  0001 C CNN
F 4 "EVQ-P7A01P" H 6575 3250 50  0001 C CNN "MPN1"
F 5 "https://www.digikey.com/product-detail/en/panasonic-electronic-components/EVQ-P7A01P/P16763TR-ND/4429447" H 6575 3250 50  0001 C CNN "Link1"
	1    6575 3250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0153
U 1 1 5D568EAC
P 6875 3625
F 0 "#PWR0153" H 6875 3375 50  0001 C CNN
F 1 "GND" H 6880 3452 50  0000 C CNN
F 2 "" H 6875 3625 50  0001 C CNN
F 3 "" H 6875 3625 50  0001 C CNN
	1    6875 3625
	1    0    0    -1  
$EndComp
Wire Wire Line
	6875 3625 6875 3250
Wire Wire Line
	6875 3250 6775 3250
Text HLabel 6125 3250 0    98   Input ~ 0
BTN2
Wire Wire Line
	6375 3250 6125 3250
$EndSCHEMATC
