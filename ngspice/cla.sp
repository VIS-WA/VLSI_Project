Carry look ahead

.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'

vp1 p1 0 pulse 1.8 1.8 0ns 1ns 1ns 10ns 20ns
vp2 p2 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns
vp3 p3 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns
vp4 p4 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns

Vg1 g1 0 pulse 1.8 1.8 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vg2 g2 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vg3 g3 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vg4 g4 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs

*----------------------------------------------------------------------
*---------------------- NOT gate / inverter
.subckt not x y $ inp out VDD GND
M1 y x gnd gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 y x vdd vdd CMOSP W={width_P} L={2*LAMBDA} AS={5*width_P*LAMBDA} 
+ PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends not

*---------------------- AND gate
.subckt and a b b_b y $ inputs comp out gnd
M1 a b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 0 b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends and

*---------------------- OR gate
.subckt or a b b_b y $ inputs comp out gnd
M1 vdd b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 a b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends or

*---------------------- XOR gate
.subckt xor a b a_b b_b y $ inputs inp_comp out gnd
M1 a_b b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2 a b_b y gnd CMOSN W={width_N} L={2*LAMBDA} AS={5*width_N*LAMBDA} 
+ PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends xor
*----------------------------------------------------------------------

*-------------------------------------------- CLA BLOCK

*  C0 = 0 
*  C1 = g1
*  C2 = g2 + p2g1
*  C3 = g3 + p3g2 + p3p2g1      
*  C4 = g4 + p4g3 + p4p3g2 + p4p3p2g1

*-------------------setting C0
vc1 cc0 0 pulse 0 0 0ns 1ps 1ps 10ns 20ns 

*-------------------setting C1

xn9 g1 g1_b not $ g1_b
xa5 vdd g1 g1_b c1 and $ c1

*-------------------setting C2

*xn10 g1 g1_b not $ g1_b
xa6 p2 g1 g1_b z2 and $ p2g1
xn11 g2 g2_b not $ g2_b
xo1 z2 g2 g2_b c2 or $ c2

*-------------------setting C3

xn12 p3 p3_b not $ p3_b

xa7 z2 p3 p3_b z41 and $ p3p2g1
xa8 p3 g2 g2_b z42 and $ p3g2
xn13 g3 g3_b not $ g3_B
xo2 z42 g3 g3_b z43 or $ g3 + p3g2
xn14 z41 z41_b not
xo3 z43 z41 z41_b c3 or $ g3 + p3g2 + p3p2g1

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
xo6 z55 z51 z51_b c4 or $ ans

*.dc vin 0 1.8 0.1
.tran 0.1n 50n

.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run
*plot v(a)
plot v(c1) v(vdd)
plot v(c2) v(vdd)
plot v(c3) v(vdd)
plot v(c4) v(vdd)

*hardcopy fig_inv_trans.eps v(b) v(c)
.endc
