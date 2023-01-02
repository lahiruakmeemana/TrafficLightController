//`timescale 1ns / 1ps
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
wire Start_Timer; //for visual purposes only
wire Expired;
wire OneHz;
wire [2:0] state;

wire [3:0] Value;
wire [1:0] Interval;


TrafficLightController uut (
    .Reset(Reset), 
    .Sensor(Sensor), 
    .WalkRequest(WalkRequest), 
    .Reprogram(Reprogram), 
    .Selector(Selector), 
    .Time_Value(Time_Value), 
    .clk(clk), 
    .LEDs(LEDs),
    .Start_Timer(Start_Timer),
    .Expired(Expired),
    .OneHz(OneHz),
    .state(state),
    .Value(Value),
    .Interval(Interval)
);

	initial begin
		// Initialize Inputs
		Reset = 0;
		Sensor = 0;
		WalkRequest = 0;
		Reprogram = 0;
		Selector = 0;
		Time_Value = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		
		
		//#1200050 WalkRequest <= 1;
		//#50 WalkRequest=0;
		//Gm only for tExt
		//#5000000 Sensor = 1;
		//#1500000 Sensor=0;
		//Gs for tExt
		//#20000000 Sensor = 1;
		//#50000 Sensor=0;
		//#100
		//walk request
		//Walk_Request = 1;
		//#20
		//Walk_Request = 0;
		// Vehicle sensor request
		#19999990 Sensor = 1;
		#30 Sensor = 0; 
		
		

        
		// Add stimulus here

	end
	
	initial begin
	forever begin
	 #5 clk = ~clk;
	end 
	end
	
      
endmodule

