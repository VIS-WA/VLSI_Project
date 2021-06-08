* SPICE3 file created from sum.ext - technology: scmos

SUM
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_N={5*LAMBDA}
.param width_P={10*LAMBDA}
.global gnd vdd

Vdd vdd	gnd 'SUPPLY'

vclk clk gnd pulse 0 1.80 0s 10ps 10ps 5n 10n


va1 da1 0 pulse 0 1.80 0ns 0ns 0ns 10ns 20ns
va2 da2 0 pulse 1.80 0 0ns 1ns 1ns 10ns 20ns
va3 da3 0 pulse 1.80 0 0ns 1ns 1ns 10ns 20ns
va4 da4 0 pulse 0 1.80 0ns 1ns 1ns 10ns 20ns

Vb1 db1 0 pulse 1.80 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb2 db2 0 pulse 1.80 0 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb3 db3 0 pulse 0 1.80 0ns 1ns 1ns 10ns 20ns $ select inv inputs
Vb4 db4 0 pulse 0 1.80 0ns 1ns 1ns 10ns 20ns $ select inv inputs


*vclk clk 0 pulse 0 1.8 0ns 0ns 0ns 5ns 10ns
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
xd1 da1 clk a1 a1_b dff
xd2 da2 clk a2 a2_b dff
xd3 da3 clk a3 a3_b dff
xd4 da4 clk a4 a4_b dff

xd5 db1 clk b1 b1_b dff
xd6 db2 clk b2 b2_b dff
xd7 db3 clk b3 b3_b dff
xd8 db4 clk b4 b4_b dff

.tran 0.1n 20n

.control
set hcopypscolor = 1 *White background for saving plots
set color0=white ** color0 is used to set the background of the plot (manual sec:17.7)
set color1=black ** color1 is used to set the grid color of the plot (manual sec:17.7)


run

plot v(clk) v(da1)+4 v(db1)+2  v(a1)+6 v(b1)+8 
plot v(clk) v(da2)+4 v(db2)+2   v(a2)+6 v(b2)+8
plot v(clk) v(da3)+4 v(db3)+2  v(a3)+6 v(b3)+8
plot v(clk) v(da4)+4 v(db4)+2   v(a4)+6 v(b4)+8


.endc
