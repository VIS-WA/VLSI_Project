Gates
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'
va a 0 pulse 0 1.8 0ns 1ns 1ns 10ns 20ns
Vb b 0 pulse 1.8 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
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
*---------------------- check
x00 b b_b not
x01 a a_b not
x1 a b a_b b_b y xor

*.dc vin 0 1.8 0.1
.tran 0.1n 50n

.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run
*plot v(a)
plot v(b) v(b_b)
plot  v(a) 
plot v(y)

*hardcopy fig_inv_trans.eps v(b) v(c)
.endc
