Prop and Generate
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'
va1 a1 0 pulse 1.8 1.8 0ns 1ns 1ns 10ns 20ns
va2 a2 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns
va3 a3 0 pulse 1.80 1.8 0ns 1ns 1ns 10ns 20ns
va4 a4 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns

Vb1 b1 0 pulse 1.8 1.8 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb2 b2 0 pulse 1.8 1.80 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb3 b3 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb4 b4 0 pulse 0 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
*Vbb b_b 0 pulse 0 1.8 0ns 1ns 1ns 10ns 20ns $ select inv inputs


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
*---------------------- P and G

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

*.dc vin 0 1.8 0.1
.tran 0.1n 50n

.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run
*plot v(a)
plot v(p1) v(g1)
plot v(p4) v(g4)
plot v(p3) v(g3)
plot v(p2) v(g2)

*hardcopy fig_inv_trans.eps v(b) v(c)
.endc
