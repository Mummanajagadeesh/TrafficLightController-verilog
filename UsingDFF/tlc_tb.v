`timescale 1ns/1ns
module TLC_tb;
// Parameters
parameter CLK_PERIOD = 10; // Clock period in ns
// Inputs
reg clk;
reg reset;
reg carA;
reg carB;
// Outputs
wire [2:0] lightsA;
wire [2:0] lightsB;
wire [5:0] state;
// Instantiate the TLC module
TLC uut (
 .clk(clk),
 .reset(reset),
 .carA(carA),
 .carB(carB),
 .lightsA(lightsA),
 .lightsB(lightsB)
);
// Connect the state output of TLC to state wire in testbench
assign state = uut.state;
// Clock generation
always #((CLK_PERIOD)/2) clk = ~clk;
// Initial values
initial begin
 clk = 0;
 reset = 1;
 carA = 0;
 carB = 0;
 #10; // Wait for a few cycles
 // Test cases
 reset = 1; carA = 0; carB = 0; #10; // 1
 reset = 1; carA = 0; carB = 0; #10; // 2
 reset = 1; carA = 0; carB = 0; #10; // 3
 reset = 1; carA = 0; carB = 0; #10; // 4
 reset = 0; carA = 0; carB = 0; #10; // 5
 reset = 0; carA = 0; carB = 1; #10; // 6
 reset = 0; carA = 0; carB = 1; #10; // 7
 reset = 0; carA = 0; carB = 1; #10; // 8
 reset = 0; carA = 0; carB = 1; #10; // 9
 reset = 0; carA = 0; carB = 0; #10; // 10
 reset = 0; carA = 1; carB = 0; #10; // 11
 reset = 0; carA = 1; carB = 0; #10; // 12
 $finish; // End simulation
end
// Display outputs
always @(posedge clk) begin
 $display("reset = %b carA = %b carB = %b : lightsA = %b lightsB = %b state =%b%b%b%b%b%b",
 reset, carA, carB, lightsA, lightsB, state[5], state[4], state[3], state[2], state[1], state[0]);
end
endmodule
