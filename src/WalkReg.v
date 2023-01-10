`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 05:51:51 PM
// Design Name: 
// Module Name: WalkReg
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


module WalkReg(
    input Sync_WalkReq,
    input WalkReg_Reset,
    input clk,
    output reg WalkReq
    );
    
    always@(posedge clk) begin
		if (WalkReg_Reset) WalkReq = 0;
		if (Sync_WalkReq) WalkReq = 1;
    end	
    
endmodule
