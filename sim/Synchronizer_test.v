`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 03:14:26 PM
// Design Name: 
// Module Name: Synchronizer
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

module Synchronizer_test;

// Inputs
reg Reset;
reg Sensor;
reg WalkRequest;
reg Reprogram;
reg clk;

// Outputs
wire Sync_Reset;
wire Sync_Sensor;
wire Sync_WalkReq;
wire Sync_Reprogram;

Synchronizer uut (
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
    
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end

initial begin
    Reset = 0;
    Sensor = 0;
    WalkRequest = 0;
    Reprogram = 0;

    #125
    Reset = 0;
    Sensor = 1;
    #10
    WalkRequest = 1;
    Reprogram = 0;

    #175
    Reset = 1;
    Sensor = 0;
    WalkRequest = 0;
    Reprogram = 0;	

end
endmodule
