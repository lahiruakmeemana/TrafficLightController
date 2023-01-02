//`timescale 1ns / 1ps
`timescale 1us / 1ns
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
    input clk,
    input [1:0] Selector,
    input [3:0] Time_Value,
    output [6:0] LEDs,
    output Expired,
    output OneHz,
    output Start_Timer,
    output [2:0] state,
    output [3:0] Value,  //for visual purposes only
    output [1:0] Interval
    /*
    output Start_Timer,
    output Expired,      //for visual purposes only
    output OneHz, //for visual purposes only
    */
    );
    
wire [1:0] Interval;
wire [3:0] Value;
wire Sync_Sensor,Sync_Reset,Sync_Reprogram,Sync_Walk,WalkReq;


Divider divider(
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .OneHz(OneHz)
);

FSM fsm(
    .Sync_Sensor(Sync_Sensor),
    .WalkReq(WalkReq),
    .Sync_Reprogram(Sync_Reprogram),
    .Expired(Expired),
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .Start_Timer(Start_Timer),
    .Interval(Interval),
    .WalkReg_Reset(WalkReg_Reset),
    .LEDs(LEDs),       // Rm,Ym,Gm,Rs,Ys,Gs,Walk
    .state(state),
    .WALK_REQ(WALK_REQ)
);
Synchronizer synchronizer(
    .Reset(Reset),
    .Sensor(Sensor),
    .WalkRequest(WalkRequest),
    .Reprogram(Reprogram),
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .Sync_Sensor(Sync_Sensor),
    .Sync_WalkReq(Sync_WalkReq),
    .Sync_Reprogram(Sync_Reprogram)  
);
Time_Parameters time_parameters(
    .Sync_Reprogram(Sync_Reprogram),
    .Sync_Reset(Sync_Reset),  //Reset is taken as input to reset time parameters to original values.
    .Selector(Selector),
    .Time_Value(Time_Value),
    .Interval(Interval),
    .clk(clk),
    .Value(Value)
    );
Timer timer(
    .Start_Timer(Start_Timer),
    .Value(Value),
    .OneHz(OneHz),
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .Expired(Expired)
);
    
WalkReg walkreg(
    .Sync_WalkReq(Sync_WalkReq),
    .WalkReg_Reset(WalkReg_Reset),
    .WalkReq(WalkReq)
    );

endmodule
