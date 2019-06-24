EESchema Schematic File Version 4
LIBS:arcade
LIBS:jt74xx
LIBS:popeye_model-cache
EELAYER 26 0
EELAYER END
$Descr A3 16535 11693
encoding utf-8
Sheet 5 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3700 2150 4250 2150
Wire Wire Line
	4250 2250 3700 2250
Wire Wire Line
	3700 2350 4250 2350
Wire Wire Line
	4250 2450 3700 2450
Wire Wire Line
	3700 2550 4250 2550
Wire Wire Line
	4250 2650 3700 2650
Wire Wire Line
	3700 2750 4250 2750
Wire Wire Line
	4250 2850 3700 2850
$Comp
L jt74xx:74LS194 4K
U 1 1 5D118809
P 6450 2350
F 0 "4K" H 6450 2300 50  0000 C CNN
F 1 "74LS194" H 6550 1900 50  0000 C CNN
F 2 "" H 6450 2350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS194" H 6450 2350 50  0001 C CNN
	1    6450 2350
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS377 3K
U 1 1 5D11AB61
P 4750 2650
F 0 "3K" H 4750 2650 50  0000 C CNN
F 1 "74LS377" H 4850 2150 50  0000 C CNN
F 2 "" H 4750 2650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS377" H 4750 2650 50  0001 C CNN
	1    4750 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2250 5950 2250
Wire Wire Line
	5950 2150 5250 2150
Wire Wire Line
	5250 2350 5950 2350
Wire Wire Line
	5950 2450 5250 2450
$Comp
L jt74xx:74LS194 4L
U 1 1 5D1217DE
P 6450 3600
F 0 "4L" H 6450 3550 50  0000 C CNN
F 1 "74LS194" H 6550 3150 50  0000 C CNN
F 2 "" H 6450 3600 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS194" H 6450 3600 50  0001 C CNN
	1    6450 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 2550 5700 2550
Wire Wire Line
	5700 2550 5700 3400
Wire Wire Line
	5700 3400 5950 3400
Wire Wire Line
	5250 2650 5600 2650
Wire Wire Line
	5600 2650 5600 3500
Wire Wire Line
	5600 3500 5950 3500
Wire Wire Line
	5250 2750 5500 2750
Wire Wire Line
	5500 2750 5500 3600
Wire Wire Line
	5500 3600 5950 3600
Wire Wire Line
	5250 2850 5350 2850
Wire Wire Line
	5350 2850 5350 3700
Wire Wire Line
	5350 3700 5950 3700
Wire Wire Line
	6950 2650 7300 2650
Wire Wire Line
	7300 2650 7300 3800
Wire Wire Line
	7300 3800 6950 3800
Wire Wire Line
	6950 3400 7200 3400
Wire Wire Line
	7200 3400 7200 2250
Wire Wire Line
	7200 2250 6950 2250
Wire Wire Line
	6950 2150 7200 2150
Text Label 7200 2150 0    50   ~ 0
VSS
$Comp
L jt74xx:74LS157 5J
U 1 1 5D122C62
P 8750 3050
F 0 "5J" H 8750 3050 50  0000 C CNN
F 1 "74LS157" H 8850 2500 50  0000 C CNN
F 2 "" H 8750 3050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 8750 3050 50  0001 C CNN
	1    8750 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 2550 8250 2550
NoConn ~ 6950 2450
NoConn ~ 6950 2350
Wire Wire Line
	8250 2750 8100 2750
Wire Wire Line
	8100 2750 8100 2850
Wire Wire Line
	8100 2850 8250 2850
Text Label 8100 2850 0    50   ~ 0
VSS
Wire Wire Line
	8250 3250 8100 3250
Wire Wire Line
	8100 3250 8100 3350
Wire Wire Line
	8100 3350 8250 3350
Text Label 8100 3350 0    50   ~ 0
VSS
NoConn ~ 9250 3000
NoConn ~ 9250 3100
Text GLabel 9450 2800 2    50   Output ~ 0
OBJV[0]
Text GLabel 9450 2900 2    50   Output ~ 0
OBJV[1]
Wire Wire Line
	9450 2800 9250 2800
Wire Wire Line
	9250 2900 9450 2900
$Comp
L arcade:ROM_2764 1K
U 1 1 5D129A49
P 3200 2750
F 0 "1K" H 3200 3615 50  0000 C CNN
F 1 "ROM_2764" H 3200 3524 50  0000 C CNN
F 2 "" H 3200 2750 50  0001 C CNN
F 3 "" H 3200 2750 50  0001 C CNN
F 4 "1k" H 3200 2750 50  0001 C CNN "simfile"
	1    3200 2750
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 4800 4250 4800
Wire Wire Line
	4250 4900 3700 4900
Wire Wire Line
	3700 5000 4250 5000
Wire Wire Line
	4250 5100 3700 5100
Wire Wire Line
	3700 5200 4250 5200
Wire Wire Line
	4250 5300 3700 5300
Wire Wire Line
	3700 5400 4250 5400
Wire Wire Line
	4250 5500 3700 5500
$Comp
L jt74xx:74LS194 4J
U 1 1 5D12A87B
P 6450 5000
F 0 "4J" H 6450 4950 50  0000 C CNN
F 1 "74LS194" H 6550 4550 50  0000 C CNN
F 2 "" H 6450 5000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS194" H 6450 5000 50  0001 C CNN
	1    6450 5000
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS377 3K?
U 1 1 5D12A882
P 4750 5300
F 0 "3K?" H 4750 5300 50  0000 C CNN
F 1 "74LS377" H 4850 4800 50  0000 C CNN
F 2 "" H 4750 5300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS377" H 4750 5300 50  0001 C CNN
	1    4750 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 4900 5950 4900
Wire Wire Line
	5950 4800 5250 4800
Wire Wire Line
	5250 5000 5950 5000
Wire Wire Line
	5950 5100 5250 5100
$Comp
L jt74xx:74LS194 5K
U 1 1 5D12A88D
P 6450 6250
F 0 "5K" H 6450 6200 50  0000 C CNN
F 1 "74LS194" H 6550 5800 50  0000 C CNN
F 2 "" H 6450 6250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS194" H 6450 6250 50  0001 C CNN
	1    6450 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5250 5200 5700 5200
Wire Wire Line
	5700 5200 5700 6050
Wire Wire Line
	5700 6050 5950 6050
Wire Wire Line
	5250 5300 5600 5300
Wire Wire Line
	5600 5300 5600 6150
Wire Wire Line
	5600 6150 5950 6150
Wire Wire Line
	5250 5400 5500 5400
Wire Wire Line
	5500 5400 5500 6250
Wire Wire Line
	5500 6250 5950 6250
Wire Wire Line
	5250 5500 5350 5500
Wire Wire Line
	5350 5500 5350 6350
Wire Wire Line
	5350 6350 5950 6350
Wire Wire Line
	6950 5300 7300 5300
Wire Wire Line
	7300 5300 7300 6450
Wire Wire Line
	7300 6450 6950 6450
Wire Wire Line
	6950 6050 7200 6050
Wire Wire Line
	7200 6050 7200 4900
Wire Wire Line
	7200 4900 6950 4900
Wire Wire Line
	6950 4800 7200 4800
NoConn ~ 6950 5100
NoConn ~ 6950 5000
$Comp
L arcade:ROM_2764 1J
U 1 1 5D12A8C0
P 3200 5400
F 0 "1J" H 3200 6265 50  0000 C CNN
F 1 "ROM_2764" H 3200 6174 50  0000 C CNN
F 2 "" H 3200 5400 50  0001 C CNN
F 3 "" H 3200 5400 50  0001 C CNN
F 4 "1J" H 3200 5400 50  0001 C CNN "simfile"
	1    3200 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6950 3500 7200 3500
Wire Wire Line
	7200 3500 7200 4800
Wire Wire Line
	6950 3900 7300 3900
Wire Wire Line
	7300 3900 7300 5200
Wire Wire Line
	7300 5200 6950 5200
Wire Wire Line
	6950 6550 7300 6550
Text Label 7300 6550 2    50   ~ 0
VSS
Text Label 5950 2750 2    50   ~ 0
VDD
Text Label 5950 4000 2    50   ~ 0
VDD
Text Label 5950 5400 2    50   ~ 0
VDD
Text Label 5950 6650 2    50   ~ 0
VDD
Wire Wire Line
	5950 6500 5800 6500
Wire Wire Line
	5800 6500 5800 5250
Wire Wire Line
	5800 2600 5950 2600
Wire Wire Line
	5950 3850 5800 3850
Connection ~ 5800 3850
Wire Wire Line
	5800 3850 5800 2600
Wire Wire Line
	5950 5250 5800 5250
Connection ~ 5800 5250
Wire Wire Line
	5800 5250 5800 3850
Text Label 6400 4450 1    50   ~ 0
S[0]
Text Label 6500 4450 1    50   ~ 0
S[1]
Wire Wire Line
	6400 4450 6400 4500
Wire Wire Line
	6500 4500 6500 4450
Text Label 6400 5700 1    50   ~ 0
S[0]
Text Label 6500 5700 1    50   ~ 0
S[1]
Wire Wire Line
	6400 5700 6400 5750
Wire Wire Line
	6500 5750 6500 5700
Text Label 6400 3050 1    50   ~ 0
S[0]
Text Label 6500 3050 1    50   ~ 0
S[1]
Wire Wire Line
	6400 3050 6400 3100
Wire Wire Line
	6500 3100 6500 3050
Text Label 6400 1800 1    50   ~ 0
S[0]
Text Label 6500 1800 1    50   ~ 0
S[1]
Wire Wire Line
	6400 1800 6400 1850
Wire Wire Line
	6500 1850 6500 1800
Wire Wire Line
	6950 6150 7450 6150
Wire Wire Line
	7450 6150 7450 3050
Wire Wire Line
	7450 3050 8250 3050
Wire Wire Line
	2600 2250 2700 2250
Wire Wire Line
	2600 2350 2700 2350
Wire Wire Line
	2600 2450 2700 2450
Wire Wire Line
	2600 2550 2700 2550
Wire Wire Line
	2600 2650 2700 2650
Wire Wire Line
	2600 2750 2700 2750
Wire Wire Line
	2600 2850 2700 2850
Wire Wire Line
	2600 2950 2700 2950
Wire Wire Line
	2600 3050 2700 3050
Wire Wire Line
	2600 3150 2700 3150
Wire Wire Line
	2600 3250 2700 3250
Wire Wire Line
	2600 3350 2700 3350
Text GLabel 2600 2250 0    50   Input ~ 0
DJ[1]
Text GLabel 2600 2350 0    50   Input ~ 0
DJ[2]
Text GLabel 2600 2450 0    50   Input ~ 0
DJ[3]
Text GLabel 2600 2550 0    50   Input ~ 0
DJ[4]
Text GLabel 2600 2650 0    50   Input ~ 0
DJ[5]
Text GLabel 2600 2750 0    50   Input ~ 0
DJ[6]
Text GLabel 2600 2850 0    50   Input ~ 0
DJ[7]
Text GLabel 2600 2950 0    50   Input ~ 0
DJ[8]
Text GLabel 2600 3050 0    50   Input ~ 0
DJ[9]
Text GLabel 2600 3150 0    50   Input ~ 0
DJ[10]
Text GLabel 2600 3250 0    50   Input ~ 0
DJ[17]
$Comp
L jt74xx:74LS86 5D
U 2 1 5D17D692
P 1850 2150
F 0 "5D" H 1850 2475 50  0000 C CNN
F 1 "74LS86" H 1850 2384 50  0000 C CNN
F 2 "" H 1850 2150 50  0001 C CNN
F 3 "74xx/74ls86.pdf" H 1850 2150 50  0001 C CNN
	2    1850 2150
	1    0    0    -1  
$EndComp
Text GLabel 1400 2250 0    50   Input ~ 0
DJ[0]
Wire Wire Line
	1400 2250 1550 2250
Wire Wire Line
	2150 2150 2700 2150
Wire Wire Line
	1550 2050 1400 2050
Text GLabel 1400 2050 0    50   Input ~ 0
INIT_EOn
Text GLabel 2600 3350 0    50   Input ~ 0
DJ[16]
Text Label 2250 2150 0    50   ~ 0
DJEO
Wire Wire Line
	2600 4900 2700 4900
Wire Wire Line
	2600 5000 2700 5000
Wire Wire Line
	2600 5100 2700 5100
Wire Wire Line
	2600 5200 2700 5200
Wire Wire Line
	2600 5300 2700 5300
Wire Wire Line
	2600 5400 2700 5400
Wire Wire Line
	2600 5500 2700 5500
Wire Wire Line
	2600 5600 2700 5600
Wire Wire Line
	2600 5700 2700 5700
Wire Wire Line
	2600 5800 2700 5800
Wire Wire Line
	2600 5900 2700 5900
Wire Wire Line
	2600 6000 2700 6000
Text GLabel 2600 4900 0    50   Input ~ 0
DJ[1]
Text GLabel 2600 5000 0    50   Input ~ 0
DJ[2]
Text GLabel 2600 5100 0    50   Input ~ 0
DJ[3]
Text GLabel 2600 5200 0    50   Input ~ 0
DJ[4]
Text GLabel 2600 5300 0    50   Input ~ 0
DJ[5]
Text GLabel 2600 5400 0    50   Input ~ 0
DJ[6]
Text GLabel 2600 5500 0    50   Input ~ 0
DJ[7]
Text GLabel 2600 5600 0    50   Input ~ 0
DJ[8]
Text GLabel 2600 5700 0    50   Input ~ 0
DJ[9]
Text GLabel 2600 5800 0    50   Input ~ 0
DJ[10]
Text GLabel 2600 5900 0    50   Input ~ 0
DJ[17]
Text GLabel 2600 6000 0    50   Input ~ 0
DJ[16]
Wire Wire Line
	2700 4800 2600 4800
Text Label 2600 4800 2    50   ~ 0
DJEO
Text Label 4250 5800 2    50   ~ 0
VSS
Text Label 4250 3150 2    50   ~ 0
VSS
$EndSCHEMATC
