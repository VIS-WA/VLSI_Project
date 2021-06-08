4 bit CLA
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'

vin_a A4 0 pulse  1.8 1.8 0ns 100ps 100ps 50ns 100ns
*vin_a A0 0 pulse  0 1.8 0ns 100ps 100ps 100ns 200ns
vin_a1 A1 0 pulse 1.8 1.8 0ns 100ps 100ps 50ns 100ns
*vin_a1 A1 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns
vin_a2 A2 0 pulse 1.8 1.8 0ns 100ps 100ps 50ns 100ns
*vin_a2 A2 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns
vin_a3 A3 0 pulse 1.8 1.8 0ns 100ps 100ps 50ns 100ns
*vin_a3 A3 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns

vin_b B4 0 pulse  1.8 0 0ns 100ps 100ps 50ns 100ns
*vin_b B0 0 pulse  0 1.8 0ns 100ps 100ps 100ns 200ns
vin_b1 B1 0 pulse 1.8 0 0ns 100ps 100ps 50ns 100ns
*vin_b1 B1 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns
vin_b2 B2 0 pulse 1.8 0 0ns 100ps 100ps 50ns 100ns
*vin_b2 B2 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns
vin_b3 B3 0 pulse 1.8 0 0ns 100ps 100ps 50ns 100ns
*vin_b3 B3 0 pulse 0 1.8 0ns 100ps 100ps 100ns 200ns

vclk clk 0 pulse 0 1.8 0ns 0ns 0ns 5ns 10ns
*vclk clk 0 pulse  0 1.8 0ns 100ps 100ps 50ns 100ns
*vin_c da1 0 pulse 1.8 0 0ns 100ps 100ps 10ns 20ns


*Vin_b04 hawak gnd pwl (0 0.25v 50ns 0.25v 50ns 0v 100ns 0v)

*Vbb b_b 0 pulse 0 1.8 0ns 1ns 1ns 10ns 20ns $ select inv inputs


*---------------------- NOT gate / inverter
.subckt not x y $ inp out 
M1 y x gnd gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 y x vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends not

*---------------------- AND gate
.subckt and a b b_b y $ inputs comp out 
M1 a b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 0 b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends and

*---------------------- OR gate
.subckt or a b b_b y $ inputs comp out 
M1 vdd b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 a b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends or

*---------------------- XOR gate
.subckt xor a b a_b b_b y $ inputs inp_comp out 
M1 a_b b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 a b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends xor

*---------------------- BUFFER gate
.subckt buff x z $ inp out 

.param width_N1={35*LAMBDA}
.param width_P1={5*LAMBDA}

M1 y x gnd gnd CMOSN W={width_N1} L={2*LAMBDA} AS={5*width_N1*LAMBDA}
+ PS={10*LAMBDA+2*width_N1} AD={5*width_N1*LAMBDA} PD={10*LAMBDA+2*width_N1}
M2 y x vdd vdd CMOSP W={width_P1} L={2*LAMBDA} AS={5*width_P1*LAMBDA}
+ PS={10*LAMBDA+2*width_P1} AD={5*width_P1*LAMBDA} PD={10*LAMBDA+2*width_P1}
M3 z y gnd gnd CMOSN W={width_N1} L={2*LAMBDA} AS={5*width_N1*LAMBDA}
+ PS={10*LAMBDA+2*width_N1} AD={5*width_N1*LAMBDA} PD={10*LAMBDA+2*width_N1}
M4 z y vdd vdd CMOSP W={width_P1} L={2*LAMBDA} AS={5*width_P1*LAMBDA}
+ PS={10*LAMBDA+2*width_P1} AD={5*width_P1*LAMBDA} PD={10*LAMBDA+2*width_P1}
.ends buff

*---------------------- NAND 2-input gate
.subckt nand a b y $ inp out 

M1 y a x gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 x b gnd gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M3 y a vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M4 y b vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends nand

*---------------------- NAND 3-input gate
.subckt nand3 a b c y $ inp out 

M1 y a x gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 x b z gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M6 z c gnd gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M3 y a vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M4 y b vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M5 y c vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends nand3

*---------------------- D Flip Flop

.subckt dff d clk q q_b $ inp out 
xnan1 d y3 y4 nand 
xnan31 clk y4 y2 y3 nand3
xnan2 clk y1 y2 nand
xnan3 y4 y2 y1 nand
xnan4 y2 q_b q nand
xnan5 y3 q q_b nand
.ends dff
*---------------------------------------------------------------------------
*---------------------- DFFying A and B
*---------------------- P and G BLOCK

xn1 a1 a1_b not $ generating complements
xn2 a2 a2_b not
xn3 a3 a3_b not
xn4 a4 a4_b not

xn5 b1 b1_b not
xn6 b2 b2_b not
xn7 b3 b3_b not
xn8 b4 b4_b not

xx1 a1 b1 a1_b b1_b p1 xor $ generating P's
xx2 a2 b2 a2_b b2_b p2 xor
xx3 a3 b3 a3_b b3_b p3 xor
xx4 a4 b4 a4_b b4_b p4 xor

xa1 a1 b1 b1_b g1 and $ generating G's
xa2 a2 b2 b2_b g2 and
xa3 a3 b3 b3_b g3 and
xa4 a4 b4 b4_b g4 and


*-------------------------------------------- CLA BLOCK

*  C0 = 0 
*  C1 = g1
*  C2 = g2 + p2g1
*  C3 = g3 + p3g2 + p3p2g1      
*  C4 = g4 + p4g3 + p4p3g2 + p4p3p2g1

vc1 cc0 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ Setting C0

*-------------------setting C1

xn9 g1 g1_b not $ g1_b
xa5 vdd g1 g1_b cc1 and $ c1

*-------------------setting C2

*xn10 g1 g1_b not $ g1_b
xa6 p2 g1 g1_b z2 and $ p2g1
xn11 g2 g2_b not $ g2_b
xo1 z2 g2 g2_b cc2 or $ c2

*-------------------setting C3

xn12 p3 p3_b not $ p3_b

xa7 z2 p3 p3_b z41 and $ p3p2g1
xa8 p3 g2 g2_b z42 and $ p3g2
xn13 g3 g3_b not $ g3_B
xo2 z42 g3 g3_b z43 or $ g3 + p3g2
xn14 z41 z41_b not
xo3 z43 z41 z41_b cc3 or $ g3 + p3g2 + p3p2g1

*--------------------setting C4

xn17 p4 p4_b not
xa9 z41 p4 p4_b z51 and $ p4p3p2g1
xa10 z42 p4 p4_b z52 and $ p4p3g2
xa11 g3 p4 p4_b z53 and $ p4g3
xn22 z51 z51_b not
xn23 z52 z52_b not
xn24 z53 z53_b not
xo4 g4 z53 z53_b z54 or $ g4 + p4g3
xo5 z54 z52 z52_b z55 or $ g4 + p4g3 +p4p3g2
xo6 z55 z51 z51_b cc4 or $ ans

*---------------------------------------------SUM BLOCK

xn15 p1 p1_b not $ p1_b
xn16 p2 p2_b not

xn18 cc1 cc1_b not $ c1_b
xn19 cc2 cc2_b not
xn21 cc3 cc3_b not
xn20 cc0 cc0_b not

xx5 cc0 p1 cc0_b p1_b ss1 xor $ generating S's
xx6 cc1 p2 cc1_b p2_b ss2 xor 
xx7 cc2 p3 cc2_b p3_b ss3 xor 
xx8 cc3 p4 cc3_b p4_b ss4 xor 

*-----------------------------------------BUFFER

xb1 ss1 ds1 buff
xb2 ss2 ds2 buff
xb3 ss3 ds3 buff
xb4 ss4 ds4 buff
xb5 cc4 dc4 buff
*xb6 cc3 c3 buff $uncomment while checking individual carry
*xb7 cc2 c2 buff
*xb8 cc1 c1 buff
*----------------------------------DFFying
*----------------------------------------------------Testing area

*xb9 hawak zs8 awak buff
*xna1 a1 b1 zna1 na1 nand
*xna2 a2 b2 zna2 na2 nand
*xna3 a3 b3 zna3 na3 nand
*----------------------------------------------------------------

.tran 0.1n 200n

.measure tran tpds3
+TRIG v(a1) val = 'SUPPLY/2' RISE = 1
+TARG v(ds4) val = 'SUPPLY/2' RISE = 1
.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run
*plot v(awak)
*plot v(a)
*plot v(s1) v(cc1)
*plot v(s2) v(cc2)
*plot v(s3) v(cc3)
*plot v(s4) v(c4)+2 v(cc4)+4
*plot v(cc2) 
*plot v(cc3) 
*plot v(c4) 
*plot v(g1) 
*plot v(g1_b) 
*plot v(g2)
*plot v(p2)
*plot v(na1) v(a1) v(b1)
*plot v(a2)+2 v(clk) v(da2)+4
plot v(a1) v(b1)+2 v(ds1)+4
plot v(a2) v(b2)+2 v(ds2) +4
plot v(a3) v(b3)+2 v(ds3) +4
plot v(a4) v(b4)+2 v(ds4) +4


*hardcopy fig_inv_trans.eps v(b) v(c)
.endc
