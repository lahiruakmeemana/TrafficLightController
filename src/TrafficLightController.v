`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 02:56:52 PM
// Design Name: 
// Module Name: TrafficLightController
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


module TrafficLightController(
    input Reset,
    input Sensor,
    input WalkRequest,
    input Reprogram,
    input [1:0] Selector,
    input [3:0] Time_Value,
    input clk,
    output [6:0] LEDs,
    output OneHz,
    output WalkReq,
    //output [3:0] Value,
    output [3:0] Anode_Activate,
    output [6:0] LED_out
    );
	 
	 wire [1:0] Interval;
	 wire [3:0] Value;
	 wire Sync_Reset,Sync_Sensor,Start_Timer,Sync_Reprogram,Expired,WalkReg_Reset,
			Sync_WalkReq;
	 
	Divider divider (
		.Sync_Reset(Sync_Reset),
		.clk(clk), 
		.OneHz(OneHz)
	);
	
	FSM fsm (
		.Sync_Sensor(Sync_Sensor), 
		.WalkReq(WalkReq), 
		.WalkReg_Reset(WalkReg_Reset), 
		.LEDs(LEDs), 
		.Interval(Interval), 
		.Start_Timer(Start_Timer), 
		.Expired(Expired), 
		.Sync_Reprogram(Sync_Reprogram), 
		.clk(clk),
		.Sync_Reset(Sync_Reset)
	);
	
	Synchronizer synchronizer (
		.Reset(Reset), 
		.Sensor(Sensor), 
		.WalkRequest(WalkRequest), 
		.Reprogram(Reprogram), 
		.clk(clk), 
		.Sync_Reprogram(Sync_Reprogram), 
		.Sync_WalkReq(Sync_WalkReq), 
		.Sync_Sensor(Sync_Sensor), 
		.Sync_Reset(Sync_Reset)
	);


	Time_Parameters time_Parameters (
			.Selector(Selector), 
			.Time_Value(Time_Value), 
			.Sync_Reprogram(Sync_Reprogram), 
			.Interval(Interval), 
			.clk(clk), 
			.Value(Value),
			.Sync_Reset(Sync_Reset)
		);
		
	Timer timer (
		.Value(Value), 
		.OneHz(OneHz), 
		.Start_Timer(Start_Timer),
		.clk(clk),
		.Expired(Expired),
		.Sync_Reset(Sync_Reset),
		.Anode_Activate(Anode_Activate),
		.LED_out(LED_out)
	);
	
	WalkReg walkReg (
		.Sync_WalkReq(Sync_WalkReq), 
		.WalkReg_Reset(WalkReg_Reset),
		.clk(clk),  
		.WalkReq(WalkReq)
	);

endmodule