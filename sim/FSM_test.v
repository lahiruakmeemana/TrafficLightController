`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 01:34:16 PM
// Design Name: 
// Module Name: FSM_test
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


module FSM_test;

reg Sync_Sensor;
reg WalkReq;
reg Sync_Reprogram;
reg Expired;
reg clk;
reg Sync_Reset;

reg OneHz;

wire Start_Timer;
wire [1:0] Interval;
wire WalkReg_Reset;
wire [6:0] LEDs;
wire [2:0] state;

FSM uut(
    .Sync_Sensor(Sync_Sensor),
    .WalkReq(WalkReq),
    .Sync_Reprogram(Sync_Reprogram),
    .Expired(Expired),
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .Start_Timer(Start_Timer),
    .Interval(Interval),
    .WalkReg_Reset(WalkReg_Reset),
    .LEDs(LEDs)
);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end
initial begin
    OneHz = 0;
    forever begin
        #500000 OneHz <= ~OneHz;
    end 
end

initial begin;
    Sync_Sensor=0;
    WalkReq=0;
    Sync_Reprogram=0;
    Expired=0;
    Sync_Reset=0;
    
    #1000000
    Expired=1;
    #5 Expired=0;
    #1000000
    Expired=1;
    #50 Expired=0;
    #1000000
    Expired=1; #5 Expired=0;
    #800000 WalkReq = 1;
    #1000000 WalkReq<=0;
    Sync_Sensor=1;
   
    Sync_Sensor=0;
    #1000000
    Expired=1;
    #5 Expired=0;
    #1000000
    Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    
    #1000000
    Expired=1;
    #5 Expired=0;
    
    #500000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
    #1000000 Expired=1;
    #5 Expired=0;
end


endmodule
