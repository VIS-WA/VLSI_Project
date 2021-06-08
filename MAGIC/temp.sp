Adder Suryasasanka_2019102036
.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width=10LAMBDA
.global gnd vdd

VDD vdd gnd 'SUPPLY'
va1 B3 0 pulse 0 1.8 0ns 100ps 100ps 10ns 20ns
vclk clk 0 pulse 1.8 0 0ns 100ps 100ps 5ns 10ns

.subckt not y x 
.param width_N={width}
.param width_P={2width}

M1 y x gnd gnd CMOSN W={width_N} L={2LAMBDA}
+AS={5width_NLAMBDA} PS={10LAMBDA+2width_N} AD={5width_NLAMBDA} PD={10LAMBDA+2width_N}

M2 y x vdd vdd CMOSP W={width_P} L={2LAMBDA}
+AS={5width_PLAMBDA} PS={10LAMBDA+2width_P} AD={5width_PLAMBDA} PD={10LAMBDA+2width_P}
.ends not

.subckt nand a b y
.param width_N={width}
.param width_P={2width}

M1 y a vdd vdd CMOSP W={width_P} L={2LAMBDA}
+AS={5width_PLAMBDA} PS={10LAMBDA+2width_P} AD={5width_PLAMBDA} PD={10LAMBDA+2width_P}

M2 y b vdd vdd CMOSP W={width_P} L={2LAMBDA}
+AS={5width_PLAMBDA} PS={10LAMBDA+2width_P} AD={5width_PLAMBDA} PD={10LAMBDA+2width_P}


M3 y a D1 gnd CMOSN W={width_N} L={2LAMBDA}
+AS={5width_NLAMBDA} PS={10LAMBDA+2width_N} AD={5width_NLAMBDA} PD={10LAMBDA+2width_N}

M4 D1 b gnd gnd CMOSN W={width_N} L={2LAMBDA}
+AS={5width_NLAMBDA} PS={10LAMBDA+2width_N} AD={5width_NLAMBDA} PD={10LAMBDA+2*width_N}

.ends nand

*.subckt d_ff clk D Q Q_bar

*x1 D clk I1 nand 
*x2 D_bar D not
*x3 D_bar clk I2 nand

*x5 I1 Q_bar Q nand
*x6 I2 Q Q_bar nand
*.ends d_ff
.subckt d_ff clk d q q_b $ inp out 
xnan1 d clk y1 nand
xnot1 d_b d not
xnan2 d_b clk y2 nand
xnan3 y1 q_b q nand
xnan4 y2 q q_b nand
.ends d_ff

x7 clk B3 output outinv d_ff 

.tran 0.1n 100n

.control
set hcopypscolor = 1
set color0=white
set color1=black

run
plot v(B3) v(clk)+2 v(output)+4

.endc
