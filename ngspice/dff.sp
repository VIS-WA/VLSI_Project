4 bit CLA
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'

*vclk clk gnd pulse 0 1.80 0s 10ps 10ps 5n 10n

*Vb4 d 0 pulse 1.80 1.80 0ns 1ns 1ns 10ns 20ns $ select inv inputs

vclk clk 0 pulse 0 1.8 0ns 1ps 1ps 5ns 10ns
Vin_d d gnd pwl (0 0v 10.0175ns 0v 10.0175ns 1.8v 100ns 1.8v)
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
*----------------------------------DFFying
xd9 d clk q q_b dff
*----------------------------------------------------Testing area
.measure tran tclkq
+TRIG v(clk) val = 'SUPPLY/2' RISE = 2
+TARG v(q) val = 'SUPPLY/2' RISE = 1


.tran 0.1n 40n

.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run
plot v(q)+4 v(d)+2 v(clk)
.endc
