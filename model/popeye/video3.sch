EESchema Schematic File Version 4
LIBS:arcade
LIBS:jt74xx
LIBS:popeye_model-cache
EELAYER 26 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 4 5
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
L jt74xx:74LS157 7R1
U 1 1 5DA67A49
P 8900 4300
F 0 "7R1" H 9100 4800 50  0000 C CNN
F 1 "74LS157" H 8900 3700 50  0000 C CNN
F 2 "" H 8900 4300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 8900 4300 50  0001 C CNN
	1    8900 4300
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS157 7S1
U 1 1 5DA67AD9
P 8900 5750
F 0 "7S1" H 9100 6250 50  0000 C CNN
F 1 "74LS157" H 8900 5150 50  0000 C CNN
F 2 "" H 8900 5750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 8900 5750 50  0001 C CNN
	1    8900 5750
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS161 7N1
U 1 1 5DA67CC8
P 6550 3300
F 0 "7N1" H 6550 3300 50  0000 C CNN
F 1 "74LS161" H 6650 2800 50  0000 C CNN
F 2 "" H 6550 3300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 6550 3300 50  0001 C CNN
	1    6550 3300
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS161 7M1
U 1 1 5DA69F95
P 6550 4750
F 0 "7M1" H 6550 4750 50  0000 C CNN
F 1 "74LS161" H 6650 4250 50  0000 C CNN
F 2 "" H 6550 4750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS161" H 6550 4750 50  0001 C CNN
	1    6550 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 3300 7050 4050
Text Label 6050 5250 2    50   ~ 0
VDD
$Comp
L jt74xx:74LS157 7P1
U 1 1 5DA6C7CB
P 8900 2850
F 0 "7P1" H 9100 3350 50  0000 C CNN
F 1 "74LS157" H 8900 2250 50  0000 C CNN
F 2 "" H 8900 2850 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 8900 2850 50  0001 C CNN
	1    8900 2850
	1    0    0    -1  
$EndComp
Text GLabel 3150 2000 0    50   Input ~ 0
AD[0]
Text GLabel 3150 2350 0    50   Input ~ 0
AD[1]
Text GLabel 3150 2700 0    50   Input ~ 0
AD[2]
Text GLabel 8400 2650 0    50   Input ~ 0
AD[6]
Text GLabel 3150 3050 0    50   Input ~ 0
AD[3]
Text GLabel 3150 3400 0    50   Input ~ 0
AD[4]
Text GLabel 8400 4000 0    50   Input ~ 0
AD[7]
Text GLabel 8400 4100 0    50   Input ~ 0
AD[8]
NoConn ~ 7050 4750
Wire Wire Line
	6050 3400 5900 3400
Wire Wire Line
	5900 3400 5900 3500
Wire Wire Line
	5900 3500 6050 3500
Wire Wire Line
	5900 3500 5900 3800
Wire Wire Line
	5900 3800 6050 3800
Connection ~ 5900 3500
Text Label 5900 3800 0    50   ~ 0
VDD
Text GLabel 5350 3600 0    50   Input ~ 0
DOTCK
Text GLabel 6050 2800 0    50   Input ~ 0
DO[0]
Text GLabel 6050 2900 0    50   Input ~ 0
DO[1]
Text GLabel 6050 3000 0    50   Input ~ 0
DO[2]
Text GLabel 6050 3100 0    50   Input ~ 0
DO[3]
Text Label 7050 2800 0    50   ~ 0
ROH[0]
Text Label 7050 2900 0    50   ~ 0
ROH[1]
Text Label 7050 3000 0    50   ~ 0
ROH[2]
Text Label 7050 3100 0    50   ~ 0
ROH[3]
Text Label 7050 4250 0    50   ~ 0
ROH[4]
Text Label 7050 4350 0    50   ~ 0
ROH[5]
Text Label 7050 4450 0    50   ~ 0
ROH[6]
Text Label 7050 4550 0    50   ~ 0
ROH[7]
Text Label 8400 2950 2    50   ~ 0
ROH[3]
Text Label 8400 2850 2    50   ~ 0
ROH[2]
Text Label 8400 3050 2    50   ~ 0
ROH[4]
Text Label 8400 3150 2    50   ~ 0
ROH[5]
Text Label 8400 4300 2    50   ~ 0
ROH[6]
Text Label 8400 4400 2    50   ~ 0
ROH[7]
Text Label 9400 2600 0    50   ~ 0
AT[0]
Text Label 9400 2700 0    50   ~ 0
AT[1]
Text Label 9400 2800 0    50   ~ 0
AT[2]
Text Label 9400 2900 0    50   ~ 0
AT[3]
Text Label 9450 4050 0    50   ~ 0
AT[4]
Text Label 9450 4150 0    50   ~ 0
AT[5]
Text Label 9450 4250 0    50   ~ 0
AT[6]
Text Label 9450 4350 0    50   ~ 0
AT[7]
Text Label 9400 5500 0    50   ~ 0
AT[8]
Text Label 9400 5600 0    50   ~ 0
AT[9]
Text Label 9400 5700 0    50   ~ 0
AT[10]
Text Label 9400 5800 0    50   ~ 0
AT[11]
Text Label 8400 5350 2    50   ~ 0
ADx[5]
$Comp
L jt74xx:74LS273 U8
U 1 1 5DA74257
P 6550 6100
F 0 "U8" H 6550 6100 50  0000 C CNN
F 1 "74LS273" H 6650 5600 50  0000 C CNN
F 2 "" H 6550 6100 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS273" H 6550 6100 50  0001 C CNN
	1    6550 6100
	1    0    0    -1  
$EndComp
Text GLabel 6050 5600 0    50   Input ~ 0
ROVI[1]
Text GLabel 6050 5700 0    50   Input ~ 0
ROVI[2]
Text GLabel 6050 5800 0    50   Input ~ 0
ROVI[3]
Text GLabel 6050 5900 0    50   Input ~ 0
ROVI[4]
Text GLabel 6050 6000 0    50   Input ~ 0
ROVI[5]
Text GLabel 6050 6100 0    50   Input ~ 0
ROVI[6]
Text GLabel 6050 6200 0    50   Input ~ 0
ROVI[7]
Text GLabel 4950 6300 0    50   Input ~ 0
ROVI[8]
$Comp
L jt74xx:74LS04 6T1
U 4 1 5DA767ED
P 5400 6300
F 0 "6T1" H 5350 6300 50  0000 C CNN
F 1 "74LS04" H 5400 6526 50  0000 C CNN
F 2 "" H 5400 6300 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 5400 6300 50  0001 C CNN
	4    5400 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 6300 6050 6300
Wire Wire Line
	5100 6300 4950 6300
Wire Wire Line
	6050 6500 4550 6500
Text GLabel 4550 6500 0    50   Input ~ 0
ROHVCK
Wire Wire Line
	4550 6500 4550 4750
Wire Wire Line
	4550 4750 6050 4750
Wire Wire Line
	4550 4750 4550 3300
Wire Wire Line
	4550 3300 6050 3300
Connection ~ 4550 4750
Text GLabel 6050 4250 0    50   Input ~ 0
DO[4]
Text GLabel 6050 4350 0    50   Input ~ 0
DO[5]
Text GLabel 6050 4450 0    50   Input ~ 0
DO[6]
Text GLabel 6050 4550 0    50   Input ~ 0
DO[7]
Text Label 6050 4850 2    50   ~ 0
VDD
Wire Wire Line
	5350 3600 5550 3600
Wire Wire Line
	5550 5050 5550 3600
Connection ~ 5550 3600
Wire Wire Line
	5550 3600 6050 3600
Wire Wire Line
	5550 5050 6050 5050
Wire Wire Line
	5650 4050 5650 4950
Wire Wire Line
	5650 4050 7050 4050
Wire Wire Line
	5650 4950 6050 4950
Text Label 7050 5600 0    50   ~ 0
ROV[1]
Text Label 7050 5700 0    50   ~ 0
ROV[2]
Text Label 7050 5800 0    50   ~ 0
ROV[3]
Text Label 7050 5900 0    50   ~ 0
ROV[4]
Text Label 7050 6000 0    50   ~ 0
ROV[5]
Text Label 7050 6100 0    50   ~ 0
ROV[6]
Text Label 7050 6200 0    50   ~ 0
ROV[7]
Text Label 7050 6300 0    50   ~ 0
ROV[8]
Wire Wire Line
	7050 6300 7750 6300
Wire Wire Line
	8400 4850 7750 4850
Wire Wire Line
	7750 4850 7750 6300
Connection ~ 7750 6300
Wire Wire Line
	7750 6300 8400 6300
Wire Wire Line
	7750 4850 7750 3400
Wire Wire Line
	7750 3400 8400 3400
Connection ~ 7750 4850
Text GLabel 4500 6600 0    50   Input ~ 0
CSBWn
Wire Wire Line
	8400 4750 7650 4750
Wire Wire Line
	7650 4750 7650 3300
Wire Wire Line
	7650 3300 8400 3300
Wire Wire Line
	8400 6200 7650 6200
Wire Wire Line
	7650 6200 7650 4750
Connection ~ 7650 4750
Text Label 8400 4500 2    50   ~ 0
ROV[1]
Text Label 8400 4600 2    50   ~ 0
ROV[2]
Text Label 8350 5750 2    50   ~ 0
ROV[3]
Text Label 8350 5850 2    50   ~ 0
ROV[4]
Text Label 8350 5950 2    50   ~ 0
ROV[5]
Text Label 8350 6050 2    50   ~ 0
ROV[6]
Wire Wire Line
	7650 6200 7650 6850
Wire Wire Line
	7650 6850 6050 6850
Wire Wire Line
	6050 6850 6050 6600
Connection ~ 7650 6200
Connection ~ 6050 6600
Wire Wire Line
	4500 6600 6050 6600
$Comp
L jt74xx:74LS00 7L1
U 4 1 5DA7C209
P 8850 1550
F 0 "7L1" H 8850 1233 50  0000 C CNN
F 1 "74LS00" H 8850 1324 50  0000 C CNN
F 2 "" H 8850 1550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74ls00" H 8850 1550 50  0001 C CNN
	4    8850 1550
	1    0    0    1   
$EndComp
Text Label 8550 1450 2    50   ~ 0
ROH[0]
Text Label 8550 1650 2    50   ~ 0
ROH[1]
$Comp
L jt74xx:74LS04 5L1
U 4 1 5DA7D290
P 9750 1950
F 0 "5L1" H 9750 2267 50  0000 C CNN
F 1 "74LS04" H 9750 2176 50  0000 C CNN
F 2 "" H 9750 1950 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 9750 1950 50  0001 C CNN
	4    9750 1950
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS74 U9
U 1 1 5DA7D937
P 10500 1650
F 0 "U9" H 10500 2128 50  0000 C CNN
F 1 "74LS74" H 10500 2037 50  0000 C CNN
F 2 "" H 10500 1650 50  0001 C CNN
F 3 "74xx/74hc_hct74.pdf" H 10500 1650 50  0001 C CNN
	1    10500 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 1550 9150 1550
Wire Wire Line
	10200 1650 10200 1950
Wire Wire Line
	10200 1950 10050 1950
Text Label 10500 1350 0    50   ~ 0
VDD
Text Label 10500 1950 0    50   ~ 0
VDD
NoConn ~ 10800 1550
$Comp
L jt74xx:74LS157 6U1
U 1 1 5DA7EE76
P 11750 1750
F 0 "6U1" H 11950 2250 50  0000 C CNN
F 1 "74LS157" H 11850 1150 50  0000 C CNN
F 2 "" H 11750 1750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 11750 1750 50  0001 C CNN
	1    11750 1750
	1    0    0    -1  
$EndComp
Wire Wire Line
	11250 1750 10800 1750
Text Label 11250 1850 2    50   ~ 0
ROV[7]
NoConn ~ 12250 1700
NoConn ~ 12250 1800
NoConn ~ 11250 1450
NoConn ~ 11250 1550
NoConn ~ 11250 1950
NoConn ~ 11250 2050
Text Label 11250 2300 2    50   ~ 0
VSS
$Comp
L jt74xx:74LS157 8T1
U 1 1 5DA81F4A
P 14150 2650
F 0 "8T1" H 14350 3150 50  0000 C CNN
F 1 "74LS157" H 14250 2050 50  0000 C CNN
F 2 "" H 14150 2650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS157" H 14150 2650 50  0001 C CNN
	1    14150 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	12250 1600 12500 1600
Wire Wire Line
	12500 1600 12500 3100
Wire Wire Line
	12500 3100 13650 3100
$Comp
L jt74xx:74LS174 8U1
U 1 1 5DA827CF
P 15600 2800
F 0 "8U1" H 15600 2800 50  0000 C CNN
F 1 "74LS174" H 15700 2300 50  0000 C CNN
F 2 "" H 15600 2800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS174" H 15600 2800 50  0001 C CNN
	1    15600 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	14650 2400 15100 2400
Wire Wire Line
	14650 2500 15100 2500
Wire Wire Line
	14650 2600 15100 2600
Wire Wire Line
	14650 2700 15100 2700
Wire Wire Line
	15100 2800 15100 2900
Text Label 15100 2800 2    50   ~ 0
VSS
NoConn ~ 16100 2800
NoConn ~ 16100 2900
Wire Wire Line
	16100 2400 16850 2400
Wire Wire Line
	16100 2500 16750 2500
Wire Wire Line
	16100 2600 16650 2600
Wire Wire Line
	16100 2700 16550 2700
Text GLabel 16950 2400 2    50   Output ~ 0
BAKC[0]
Text GLabel 16950 2500 2    50   Output ~ 0
BAKC[1]
Text GLabel 16950 2600 2    50   Output ~ 0
BAKC[2]
Text GLabel 16950 2700 2    50   Output ~ 0
BAKC[3]
Wire Wire Line
	12250 1500 14900 1500
Wire Wire Line
	14900 1500 14900 3100
Wire Wire Line
	14900 3100 15100 3100
Text Label 14750 1500 2    50   ~ 0
BAKCK
Text Label 15100 3300 2    50   ~ 0
VDD
$Comp
L jt74xx:74LS257 7T1
U 1 1 5DA8982D
P 15600 4550
F 0 "7T1" H 15600 4550 50  0000 C CNN
F 1 "74LS257" H 15700 3850 50  0000 C CNN
F 2 "" H 15600 4550 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS257" H 15600 4550 50  0001 C CNN
	1    15600 4550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	16850 2400 16850 3950
Wire Wire Line
	16850 3950 16100 3950
Connection ~ 16850 2400
Wire Wire Line
	16850 2400 16950 2400
Wire Wire Line
	16750 2500 16750 4250
Wire Wire Line
	16750 4250 16100 4250
Connection ~ 16750 2500
Wire Wire Line
	16750 2500 16950 2500
Wire Wire Line
	16650 2600 16650 4850
Wire Wire Line
	16650 4850 16100 4850
Connection ~ 16650 2600
Wire Wire Line
	16650 2600 16950 2600
Wire Wire Line
	16550 2700 16550 4550
Wire Wire Line
	16550 4550 16100 4550
Connection ~ 16550 2700
Wire Wire Line
	16550 2700 16950 2700
Text GLabel 16100 4050 2    50   Input ~ 0
DD[0]
Text GLabel 16100 4350 2    50   Input ~ 0
DD[1]
Text GLabel 16100 4650 2    50   Input ~ 0
DD[3]
Text GLabel 16100 4950 2    50   Input ~ 0
DD[2]
$Comp
L jt74xx:74LS257 7U1
U 1 1 5DA8F966
P 15600 6150
F 0 "7U1" H 15600 6150 50  0000 C CNN
F 1 "74LS257" H 15700 5450 50  0000 C CNN
F 2 "" H 15600 6150 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS257" H 15600 6150 50  0001 C CNN
	1    15600 6150
	-1   0    0    -1  
$EndComp
Text Label 16100 5550 0    50   ~ 0
DD[0]
Text Label 16100 5850 0    50   ~ 0
DD[1]
Text Label 16100 6450 0    50   ~ 0
DD[2]
Text Label 16100 6150 0    50   ~ 0
DD[3]
Wire Wire Line
	16850 3950 16850 5650
Wire Wire Line
	16850 5650 16100 5650
Connection ~ 16850 3950
Wire Wire Line
	16750 4250 16750 5950
Wire Wire Line
	16750 5950 16100 5950
Connection ~ 16750 4250
Wire Wire Line
	16550 4550 16550 6250
Wire Wire Line
	16550 6250 16100 6250
Connection ~ 16550 4550
Wire Wire Line
	16650 4850 16650 6550
Wire Wire Line
	16650 6550 16100 6550
Connection ~ 16650 4850
Wire Wire Line
	16100 5150 17050 5150
Wire Wire Line
	17050 5150 17050 6750
Wire Wire Line
	17050 6750 16100 6750
Wire Wire Line
	17050 5150 17050 3500
Connection ~ 17050 5150
Text Label 13650 3200 2    50   ~ 0
VSS
Wire Wire Line
	11250 1350 10950 1350
$Comp
L jt74xx:74LS04 6T1
U 5 1 5DA99DCA
P 10400 3500
F 0 "6T1" H 10350 3500 50  0000 C CNN
F 1 "74LS04" H 10400 3726 50  0000 C CNN
F 2 "" H 10400 3500 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 10400 3500 50  0001 C CNN
	5    10400 3500
	1    0    0    -1  
$EndComp
Text GLabel 11250 1250 0    50   Input ~ 0
MEMWR0
Wire Wire Line
	9450 1950 4550 1950
Wire Wire Line
	4550 1950 4550 3300
Connection ~ 4550 3300
Wire Wire Line
	10950 1350 10950 3500
Connection ~ 10950 3500
Wire Wire Line
	10950 3500 17050 3500
Wire Wire Line
	10700 3500 10950 3500
Wire Wire Line
	7650 6850 9750 6850
Wire Wire Line
	9750 6850 9750 2200
Wire Wire Line
	9750 2200 11250 2200
Connection ~ 7650 6850
$Comp
L arcade:RAM_2016 8P1
U 1 1 5DAADF8C
P 12200 4550
AR Path="/5DAADF8C" Ref="8P1"  Part="1" 
AR Path="/5DA6783D/5DAADF8C" Ref="8P1"  Part="1" 
F 0 "8P1" H 12175 5415 50  0000 C CNN
F 1 "RAM_2016" H 12175 5324 50  0000 C CNN
F 2 "" H 12200 4550 50  0001 C CNN
F 3 "" H 12200 4550 50  0001 C CNN
	1    12200 4550
	1    0    0    -1  
$EndComp
$Comp
L arcade:RAM_2016 8S1
U 1 1 5DAAE0B1
P 12200 6600
AR Path="/5DAAE0B1" Ref="8S1"  Part="1" 
AR Path="/5DA6783D/5DAAE0B1" Ref="8S1"  Part="1" 
F 0 "8S1" H 12175 7465 50  0000 C CNN
F 1 "RAM_2016" H 12175 7374 50  0000 C CNN
F 2 "" H 12200 6600 50  0001 C CNN
F 3 "" H 12200 6600 50  0001 C CNN
	1    12200 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	12900 3950 13300 3950
Wire Wire Line
	13300 3950 13300 6000
Wire Wire Line
	13300 6000 12900 6000
Connection ~ 13300 3950
Wire Wire Line
	13300 3950 15100 3950
Wire Wire Line
	12900 4050 13400 4050
Wire Wire Line
	13400 4250 13400 4050
Wire Wire Line
	13400 4250 15100 4250
Wire Wire Line
	13400 4250 13400 6100
Wire Wire Line
	13400 6100 12900 6100
Connection ~ 13400 4250
Wire Wire Line
	12900 4150 13500 4150
Wire Wire Line
	13500 4150 13500 4850
Wire Wire Line
	13500 6200 12900 6200
Wire Wire Line
	15100 4850 13500 4850
Connection ~ 13500 4850
Wire Wire Line
	13500 4850 13500 6200
Wire Wire Line
	12900 4250 13200 4250
Wire Wire Line
	13200 4250 13200 4550
Wire Wire Line
	13200 6300 12900 6300
Wire Wire Line
	15100 4550 13200 4550
Connection ~ 13200 4550
Wire Wire Line
	13200 4550 13200 6300
Wire Wire Line
	12900 4350 13100 4350
Wire Wire Line
	13100 4350 13100 5550
Wire Wire Line
	13100 6400 12900 6400
Wire Wire Line
	15100 5550 13100 5550
Connection ~ 13100 5550
Wire Wire Line
	13100 5550 13100 6400
Wire Wire Line
	12900 4450 13650 4450
Wire Wire Line
	13650 4450 13650 5850
Wire Wire Line
	13650 6500 12900 6500
Wire Wire Line
	15100 5850 13650 5850
Connection ~ 13650 5850
Wire Wire Line
	13650 5850 13650 6500
Wire Wire Line
	12900 4550 13000 4550
Wire Wire Line
	13000 4550 13000 6450
Wire Wire Line
	13000 6600 12900 6600
Wire Wire Line
	15100 6450 13000 6450
Connection ~ 13000 6450
Wire Wire Line
	13000 6450 13000 6600
Wire Wire Line
	12900 4650 13750 4650
Wire Wire Line
	13750 4650 13750 6150
Wire Wire Line
	13750 6700 12900 6700
Wire Wire Line
	15100 6150 13750 6150
Connection ~ 13750 6150
Wire Wire Line
	13750 6150 13750 6700
Text Label 11450 3950 2    50   ~ 0
AT[0]
Text Label 11450 4050 2    50   ~ 0
AT[1]
Text Label 11450 4150 2    50   ~ 0
AT[2]
Text Label 11450 4250 2    50   ~ 0
AT[3]
Text Label 11450 4350 2    50   ~ 0
AT[4]
Text Label 11450 4450 2    50   ~ 0
AT[5]
Text Label 11450 4550 2    50   ~ 0
AT[6]
Text Label 11450 4650 2    50   ~ 0
AT[7]
Text Label 11450 4750 2    50   ~ 0
AT[8]
Text Label 11450 4850 2    50   ~ 0
AT[9]
Text Label 11450 4950 2    50   ~ 0
AT[10]
Text Label 11450 6000 2    50   ~ 0
AT[0]
Text Label 11450 6100 2    50   ~ 0
AT[1]
Text Label 11450 6200 2    50   ~ 0
AT[2]
Text Label 11450 6300 2    50   ~ 0
AT[3]
Text Label 11450 6400 2    50   ~ 0
AT[4]
Text Label 11450 6500 2    50   ~ 0
AT[5]
Text Label 11450 6600 2    50   ~ 0
AT[6]
Text Label 11450 6700 2    50   ~ 0
AT[7]
Text Label 11450 6800 2    50   ~ 0
AT[8]
Text Label 11450 6900 2    50   ~ 0
AT[9]
Text Label 11450 7000 2    50   ~ 0
AT[10]
$Comp
L jt74xx:74LS04 6T1
U 2 1 5DAE7CBE
P 14650 7650
F 0 "6T1" H 14650 7967 50  0000 C CNN
F 1 "74LS04" H 14650 7876 50  0000 C CNN
F 2 "" H 14650 7650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 14650 7650 50  0001 C CNN
	2    14650 7650
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 6T1
U 3 1 5DAE7D98
P 15450 7650
F 0 "6T1" H 15450 7967 50  0000 C CNN
F 1 "74LS04" H 15450 7876 50  0000 C CNN
F 2 "" H 15450 7650 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 15450 7650 50  0001 C CNN
	3    15450 7650
	1    0    0    -1  
$EndComp
Wire Wire Line
	15150 7650 14950 7650
Wire Wire Line
	16100 5250 16400 5250
Wire Wire Line
	16400 5250 16400 6850
Wire Wire Line
	16400 7650 15750 7650
Wire Wire Line
	16100 6850 16400 6850
Connection ~ 16400 6850
Wire Wire Line
	16400 6850 16400 7650
Wire Wire Line
	14350 7650 12300 7650
Wire Wire Line
	12300 7350 12300 7650
Connection ~ 12300 7650
Text GLabel 10500 7650 0    50   Input ~ 0
DWRBKn
Wire Wire Line
	10500 7650 10650 7650
Wire Wire Line
	10650 7650 10650 5650
Wire Wire Line
	10650 5650 12300 5650
Wire Wire Line
	12300 5650 12300 5300
Connection ~ 10650 7650
Wire Wire Line
	10650 7650 12300 7650
$Comp
L jt74xx:74LS04 6T1
U 1 1 5DB0812E
P 11300 5400
F 0 "6T1" H 11300 5717 50  0000 C CNN
F 1 "74LS04" H 11300 5626 50  0000 C CNN
F 2 "" H 11300 5400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 11300 5400 50  0001 C CNN
	1    11300 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	12100 5300 12100 5400
Wire Wire Line
	12100 5400 11600 5400
Wire Wire Line
	11000 5400 11000 5800
Wire Wire Line
	11000 7450 12100 7450
Wire Wire Line
	12100 7450 12100 7350
Wire Wire Line
	9400 5800 11000 5800
Connection ~ 11000 5800
Wire Wire Line
	11000 5800 11000 7450
$Comp
L jt74xx:74LS04 5U1
U 2 1 5DB1A4D0
P 3450 2000
F 0 "5U1" H 3450 2000 50  0000 C CNN
F 1 "74LS04" H 3600 2100 50  0000 C CNN
F 2 "" H 3450 2000 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 2000 50  0001 C CNN
	2    3450 2000
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 5U1
U 5 1 5DB1A873
P 3450 2350
F 0 "5U1" H 3450 2350 50  0000 C CNN
F 1 "74LS04" H 3600 2450 50  0000 C CNN
F 2 "" H 3450 2350 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 2350 50  0001 C CNN
	5    3450 2350
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 5U1
U 6 1 5DB1A8BD
P 3450 2700
F 0 "5U1" H 3450 2700 50  0000 C CNN
F 1 "74LS04" H 3600 2800 50  0000 C CNN
F 2 "" H 3450 2700 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 2700 50  0001 C CNN
	6    3450 2700
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 5U1
U 3 1 5DB1A90F
P 3450 3050
F 0 "5U1" H 3450 3050 50  0000 C CNN
F 1 "74LS04" H 3600 3150 50  0000 C CNN
F 2 "" H 3450 3050 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 3050 50  0001 C CNN
	3    3450 3050
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 5U1
U 4 1 5DB1A991
P 3450 3400
F 0 "5U1" H 3450 3400 50  0000 C CNN
F 1 "74LS04" H 3600 3500 50  0000 C CNN
F 2 "" H 3450 3400 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 3400 50  0001 C CNN
	4    3450 3400
	1    0    0    -1  
$EndComp
$Comp
L jt74xx:74LS04 5U1
U 1 1 5DB1A9E7
P 3450 3750
F 0 "5U1" H 3450 3750 50  0000 C CNN
F 1 "74LS04" H 3600 3850 50  0000 C CNN
F 2 "" H 3450 3750 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS04" H 3450 3750 50  0001 C CNN
	1    3450 3750
	1    0    0    -1  
$EndComp
Text Label 3750 2000 0    50   ~ 0
ADx[0]
Text Label 3750 2350 0    50   ~ 0
ADx[1]
Text Label 3750 2700 0    50   ~ 0
ADx[2]
Text GLabel 3150 3750 0    50   Input ~ 0
AD[5]
Text Label 3750 3750 0    50   ~ 0
ADx[5]
Text Label 3750 3050 0    50   ~ 0
ADx[3]
Text Label 3750 3400 0    50   ~ 0
ADx[4]
Text Label 8400 2350 2    50   ~ 0
ADx[0]
Text Label 8400 2450 2    50   ~ 0
ADx[1]
Text Label 8400 2550 2    50   ~ 0
ADx[2]
Text Label 8400 3800 2    50   ~ 0
ADx[3]
Text Label 8400 3900 2    50   ~ 0
ADx[4]
Text Label 11800 5400 0    50   ~ 0
AT11n
Text Label 12950 3950 0    50   ~ 0
BK[0]
Text Label 12950 4050 0    50   ~ 0
BK[1]
Text Label 12950 4150 0    50   ~ 0
BK[2]
Text Label 12950 4250 0    50   ~ 0
BK[3]
Text Label 12950 4350 0    50   ~ 0
BK[4]
Text Label 12950 4450 0    50   ~ 0
BK[5]
Text Label 12950 4550 0    50   ~ 0
BK[6]
Text Label 12950 4650 0    50   ~ 0
BK[7]
Text Label 13650 2150 2    50   ~ 0
BK[0]
Text Label 13650 2250 2    50   ~ 0
BK[1]
Text Label 13650 2350 2    50   ~ 0
BK[2]
Text Label 13650 2450 2    50   ~ 0
BK[3]
Text Label 13650 2650 2    50   ~ 0
BK[4]
Text Label 13650 2750 2    50   ~ 0
BK[5]
Text Label 13650 2850 2    50   ~ 0
BK[6]
Text Label 13650 2950 2    50   ~ 0
BK[7]
Wire Wire Line
	9400 4050 9450 4050
Wire Wire Line
	9450 4150 9400 4150
Wire Wire Line
	9400 4250 9450 4250
Wire Wire Line
	9450 4350 9400 4350
Wire Wire Line
	8350 5750 8400 5750
Wire Wire Line
	8400 5850 8350 5850
Wire Wire Line
	8350 5950 8400 5950
Wire Wire Line
	8400 6050 8350 6050
Text GLabel 8300 5450 0    50   Input ~ 0
AD[10]
Wire Wire Line
	8300 5450 8400 5450
Text GLabel 8300 5550 0    50   Input ~ 0
AD[11]
Wire Wire Line
	8300 5550 8400 5550
Text GLabel 8300 5250 0    50   Input ~ 0
AD[9]
Wire Wire Line
	8300 5250 8400 5250
Text GLabel 10050 3500 0    50   Input ~ 0
AD[1]
Wire Wire Line
	10050 3500 10100 3500
$EndSCHEMATC
