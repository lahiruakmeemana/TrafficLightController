`timescale 1ns / 1ps
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


module Synchronizer(
    input Reset,
    input Sensor,
    input WalkRequest,
    input Reprogram,
    input clk,
    output reg Sync_Reset,
    output reg Sync_Sensor,
    output reg Sync_WalkReq,
    output reg Sync_Reprogram    
    );
    
    always @ (posedge clk) begin
        Sync_Reset <= Reset;
        Sync_Sensor <= Sensor;
        Sync_WalkReq <= WalkRequest;
        Sync_Reprogram <= Reprogram;
	
	end	
	
endmodule


