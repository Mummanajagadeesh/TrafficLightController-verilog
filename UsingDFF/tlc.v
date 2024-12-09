module TLC(clk, reset, carA, carB, lightsA, lightsB) ;
input clk ; // clock
input reset ; // reset
input carA ; // a car is waiting on A Street
input carB ; // a car is waiting on B Street
output[2:0] lightsA ; // Red, Yellow, Green lights for A Street
output[2:0] lightsB ; // Red, Yellow, Green lights for B Street
reg ag2, ay, ag1, bg2, by, bg1 ; // state bits
wire nag2, nay, nag1, nbg2, nby, nbg1 ; // next state bits
wire[5:0] state ; // for observation only
assign state = {ag2, ay, ag1, bg2, by, bg1} ;
// state equations
assign
nag2 = ag1|(ag2 & ~carB)|reset ,               // D1 = Q3 + (~CB)•(Q1) + reset 
nay = ag2 & carB ,                                                                        // D2 = Q1•CB
nbg1 = ay ,                                                                                            // D3 = Q5
nbg2 = (bg1|(bg2 & ~carA))&~reset,         // D4 = (Q6 + (Q4•(~CA)) + reset
nby = bg2 & carA ,                                                                        // D5 = Q4•CA
nag1 = by ;                                                                                            // D6 = Q2
// flip flops
always @(posedge clk)
{ag2, ay, ag1, bg2, by, bg1} = {nag2, nay, nag1, nbg2, nby, nbg1} ;
// output equations
assign
lightsA[2] = by | lightsB[0] | reset , // red 
lightsA[1] = ay & ~reset , // yellow
lightsA[0] = (ag1 | ag2) & ~reset, // green
lightsB[2] = ay | lightsA[0] | reset, // red
lightsB[1] = by & ~reset, // yellow
lightsB[0] = (bg1 | bg2) & ~reset ; // green
endmodule
