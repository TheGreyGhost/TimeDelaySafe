EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
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
L PICAXE:PICAXEM2 U1
U 1 1 61B6AA9D
P 4750 2350
F 0 "U1" H 4750 2431 50  0000 C CNN
F 1 "PICAXEM2" H 4750 2340 50  0000 C CNN
F 2 "" H 4750 2350 50  0001 C CNN
F 3 "" H 4750 2350 50  0001 C CNN
	1    4750 2350
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 61B6AFBA
P 3250 1450
F 0 "SW3" V 3296 1402 50  0000 R CNN
F 1 "OpenButton" V 3205 1402 50  0000 R CNN
F 2 "" H 3250 1650 50  0001 C CNN
F 3 "~" H 3250 1650 50  0001 C CNN
	1    3250 1450
	0    -1   -1   0   
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 61B6B482
P 3150 3300
F 0 "SW2" V 3196 3252 50  0000 R CNN
F 1 "LockButton" V 3105 3252 50  0000 R CNN
F 2 "" H 3150 3500 50  0001 C CNN
F 3 "~" H 3150 3500 50  0001 C CNN
	1    3150 3300
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_US R4
U 1 1 61B6BBB4
P 3250 1900
F 0 "R4" H 3318 1946 50  0000 L CNN
F 1 "10k" H 3318 1855 50  0000 L CNN
F 2 "" V 3290 1890 50  0001 C CNN
F 3 "~" H 3250 1900 50  0001 C CNN
	1    3250 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B6C1F4
P 4750 3600
F 0 "#PWR?" H 4750 3350 50  0001 C CNN
F 1 "GND" H 4755 3427 50  0000 C CNN
F 2 "" H 4750 3600 50  0001 C CNN
F 3 "" H 4750 3600 50  0001 C CNN
	1    4750 3600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61B6C706
P 4350 2050
F 0 "#PWR?" H 4350 1900 50  0001 C CNN
F 1 "+5V" H 4365 2223 50  0000 C CNN
F 2 "" H 4350 2050 50  0001 C CNN
F 3 "" H 4350 2050 50  0001 C CNN
	1    4350 2050
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 61B6CADD
P 6900 2150
F 0 "#PWR?" H 6900 2000 50  0001 C CNN
F 1 "+3V0" H 6915 2323 50  0000 C CNN
F 2 "" H 6900 2150 50  0001 C CNN
F 3 "" H 6900 2150 50  0001 C CNN
	1    6900 2150
	1    0    0    -1  
$EndComp
$Comp
L Motor:Motor_DC M1
U 1 1 61B6D35B
P 6900 2550
F 0 "M1" H 7058 2546 50  0000 L CNN
F 1 "UnlockMotor" H 7058 2455 50  0000 L CNN
F 2 "" H 6900 2460 50  0001 C CNN
F 3 "~" H 6900 2460 50  0001 C CNN
	1    6900 2550
	1    0    0    -1  
$EndComp
$Comp
L Transistor_BJT:PN2222A Q1
U 1 1 61B6DBBD
P 6800 3200
F 0 "Q1" H 6991 3246 50  0000 L CNN
F 1 "KN2222A" H 6991 3155 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 7000 3125 50  0001 L CIN
F 3 "http://www.fairchildsemi.com/ds/PN/PN2222A.pdf" H 6800 3200 50  0001 L CNN
	1    6800 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 61B6E2A3
P 6250 2200
F 0 "D1" V 6289 2083 50  0000 R CNN
F 1 "LED" V 6198 2083 50  0000 R CNN
F 2 "" H 6250 2200 50  0001 C CNN
F 3 "~" H 6250 2200 50  0001 C CNN
	1    6250 2200
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_POT_US RV1
U 1 1 61B6EE65
P 3150 3700
F 0 "RV1" H 3082 3746 50  0000 R CNN
F 1 "9k" H 3082 3655 50  0000 R CNN
F 2 "" H 3150 3700 50  0001 C CNN
F 3 "~" H 3150 3700 50  0001 C CNN
	1    3150 3700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B6FF0D
P 3150 4000
F 0 "#PWR?" H 3150 3750 50  0001 C CNN
F 1 "GND" H 3155 3827 50  0000 C CNN
F 2 "" H 3150 4000 50  0001 C CNN
F 3 "" H 3150 4000 50  0001 C CNN
	1    3150 4000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B6FF4C
P 3250 2100
F 0 "#PWR?" H 3250 1850 50  0001 C CNN
F 1 "GND" H 3255 1927 50  0000 C CNN
F 2 "" H 3250 2100 50  0001 C CNN
F 3 "" H 3250 2100 50  0001 C CNN
	1    3250 2100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B70245
P 6900 3600
F 0 "#PWR?" H 6900 3350 50  0001 C CNN
F 1 "GND" H 6905 3427 50  0000 C CNN
F 2 "" H 6900 3600 50  0001 C CNN
F 3 "" H 6900 3600 50  0001 C CNN
	1    6900 3600
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B70563
P 6250 2450
F 0 "#PWR?" H 6250 2200 50  0001 C CNN
F 1 "GND" H 6255 2277 50  0000 C CNN
F 2 "" H 6250 2450 50  0001 C CNN
F 3 "" H 6250 2450 50  0001 C CNN
	1    6250 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R_US R2
U 1 1 61B71B08
P 6200 3200
F 0 "R2" V 6405 3200 50  0000 C CNN
F 1 "390" V 6314 3200 50  0000 C CNN
F 2 "" V 6240 3190 50  0001 C CNN
F 3 "~" H 6200 3200 50  0001 C CNN
	1    6200 3200
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61B752B7
P 3250 1050
F 0 "#PWR?" H 3250 900 50  0001 C CNN
F 1 "+5V" H 3265 1223 50  0000 C CNN
F 2 "" H 3250 1050 50  0001 C CNN
F 3 "" H 3250 1050 50  0001 C CNN
	1    3250 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61B75545
P 3150 2900
F 0 "#PWR?" H 3150 2750 50  0001 C CNN
F 1 "+5V" H 3165 3073 50  0000 C CNN
F 2 "" H 3150 2900 50  0001 C CNN
F 3 "" H 3150 2900 50  0001 C CNN
	1    3150 2900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 61B764BC
P 5850 3900
F 0 "SW1" V 5896 3852 50  0000 R CNN
F 1 "HomeSensor" V 5805 3852 50  0000 R CNN
F 2 "" H 5850 4100 50  0001 C CNN
F 3 "~" H 5850 4100 50  0001 C CNN
	1    5850 3900
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_US R3
U 1 1 61B76795
P 5850 4350
F 0 "R3" H 5782 4304 50  0000 R CNN
F 1 "10k" H 5782 4395 50  0000 R CNN
F 2 "" V 5890 4340 50  0001 C CNN
F 3 "~" H 5850 4350 50  0001 C CNN
	1    5850 4350
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B76ACD
P 5850 4650
F 0 "#PWR?" H 5850 4400 50  0001 C CNN
F 1 "GND" H 5855 4477 50  0000 C CNN
F 2 "" H 5850 4650 50  0001 C CNN
F 3 "" H 5850 4650 50  0001 C CNN
	1    5850 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 3850 3150 4000
Wire Wire Line
	3150 3550 3150 3500
Wire Wire Line
	3150 3100 3150 2900
Wire Wire Line
	3250 1650 3250 1700
Wire Wire Line
	3250 2050 3250 2100
Wire Wire Line
	3250 1050 3250 1250
Wire Wire Line
	4350 2050 4350 2450
Wire Wire Line
	4350 2450 4750 2450
Wire Wire Line
	4750 3450 4750 3600
Wire Wire Line
	6250 1900 6250 2050
Wire Wire Line
	6250 2350 6250 2450
Wire Wire Line
	6900 2150 6900 2250
Wire Wire Line
	6900 3400 6900 3600
Wire Wire Line
	6350 3200 6600 3200
Wire Wire Line
	5850 4100 5850 4150
Wire Wire Line
	5850 4500 5850 4650
Wire Wire Line
	5450 2750 5700 2750
Wire Wire Line
	5700 2750 5700 1600
Wire Wire Line
	5700 1600 6250 1600
Wire Wire Line
	6050 2900 6050 3200
Wire Wire Line
	3150 3450 4050 3450
Wire Wire Line
	4050 3450 4050 3050
Wire Wire Line
	4050 2900 3650 2900
Wire Wire Line
	3650 2900 3650 3700
Wire Wire Line
	3650 3700 3300 3700
Wire Wire Line
	4050 2750 3750 2750
Wire Wire Line
	3750 2750 3750 1700
Wire Wire Line
	3750 1700 3250 1700
Connection ~ 3250 1700
Wire Wire Line
	3250 1700 3250 1750
Wire Wire Line
	5450 3050 5450 4150
Wire Wire Line
	5450 4150 5850 4150
Connection ~ 5850 4150
Wire Wire Line
	5850 4150 5850 4200
$Comp
L Device:R_US R1
U 1 1 61B71F6F
P 6250 1750
F 0 "R1" H 6182 1704 50  0000 R CNN
F 1 "390" H 6182 1795 50  0000 R CNN
F 2 "" V 6290 1740 50  0001 C CNN
F 3 "~" H 6250 1750 50  0001 C CNN
	1    6250 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	5850 2900 5850 3700
Wire Wire Line
	5450 2900 5850 2900
Connection ~ 5850 2900
Wire Wire Line
	5850 2900 6050 2900
$Comp
L Device:D D1
U 1 1 61B81573
P 7800 2600
F 0 "D1" V 7754 2679 50  0000 L CNN
F 1 "D" V 7845 2679 50  0000 L CNN
F 2 "" H 7800 2600 50  0001 C CNN
F 3 "~" H 7800 2600 50  0001 C CNN
	1    7800 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	6900 2900 7800 2900
Wire Wire Line
	7800 2900 7800 2750
Wire Wire Line
	6900 2850 6900 2900
Connection ~ 6900 2900
Wire Wire Line
	6900 2900 6900 3000
Wire Wire Line
	7800 2450 7800 2250
Wire Wire Line
	7800 2250 6900 2250
Connection ~ 6900 2250
Wire Wire Line
	6900 2250 6900 2350
$Comp
L power:PWR_FLAG #FLG?
U 1 1 61B83CF6
P 1500 2000
F 0 "#FLG?" H 1500 2075 50  0001 C CNN
F 1 "PWR_FLAG" H 1500 2173 50  0000 C CNN
F 2 "" H 1500 2000 50  0001 C CNN
F 3 "~" H 1500 2000 50  0001 C CNN
	1    1500 2000
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG?
U 1 1 61B84324
P 1500 2700
F 0 "#FLG?" H 1500 2775 50  0001 C CNN
F 1 "PWR_FLAG" H 1500 2873 50  0000 C CNN
F 2 "" H 1500 2700 50  0001 C CNN
F 3 "~" H 1500 2700 50  0001 C CNN
	1    1500 2700
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG?
U 1 1 61B84B39
P 1500 3350
F 0 "#FLG?" H 1500 3425 50  0001 C CNN
F 1 "PWR_FLAG" H 1500 3523 50  0000 C CNN
F 2 "" H 1500 3350 50  0001 C CNN
F 3 "~" H 1500 3350 50  0001 C CNN
	1    1500 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61B85490
P 1500 3450
F 0 "#PWR?" H 1500 3200 50  0001 C CNN
F 1 "GND" H 1505 3277 50  0000 C CNN
F 2 "" H 1500 3450 50  0001 C CNN
F 3 "" H 1500 3450 50  0001 C CNN
	1    1500 3450
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 61B86294
P 1500 1900
F 0 "#PWR?" H 1500 1750 50  0001 C CNN
F 1 "+5V" H 1515 2073 50  0000 C CNN
F 2 "" H 1500 1900 50  0001 C CNN
F 3 "" H 1500 1900 50  0001 C CNN
	1    1500 1900
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 61B8A3FD
P 1500 2550
F 0 "#PWR?" H 1500 2400 50  0001 C CNN
F 1 "+3V0" H 1515 2723 50  0000 C CNN
F 2 "" H 1500 2550 50  0001 C CNN
F 3 "" H 1500 2550 50  0001 C CNN
	1    1500 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 1900 1500 2000
Wire Wire Line
	1500 2550 1500 2700
Wire Wire Line
	1500 3350 1500 3450
$EndSCHEMATC
