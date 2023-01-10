`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 03:22:12 PM
// Design Name: 
// Module Name: TrafficLightController_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TrafficLightController_test;
reg Reset;
reg Sensor;
reg WalkRequest;
reg Reprogram;
reg [1:0] Selector;
reg [3:0] Time_Value;
reg clk;

// Outputs
wire [6:0] LEDs;
wire OneHz;
wire WalkReq;


wire [3:0] Anode_Activate;
wire [6:0] LED_out;

TrafficLightController uut (
    .Reset(Reset), 
    .Sensor(Sensor), 
    .WalkRequest(WalkRequest), 
    .Reprogram(Reprogram), 
    .Selector(Selector), 
    .Time_Value(Time_Value), 
    .clk(clk), 
    .LEDs(LEDs),
    .WalkReq(WalkReq),
    .OneHz(OneHz),
    .Anode_Activate(Anode_Activate),
    .LED_out(LED_out)
);

	initial begin
		// Initialize Inputs
		Reset = 1;
		Sensor = 0;
		WalkRequest = 0;
		Reprogram = 0;
		Selector = 0;
		Time_Value = 0;
		clk = 0;
        #11 Reset=0;
		
	
		#19999990 Sensor = 1;
		#30 Sensor = 0; 
		#9999990 WalkRequest = 1;
		#30 WalkRequest = 0; 

	end
	
	initial begin
		forever begin
	 		#5 clk = ~clk;
		end 
	end
	
      
endmodule

