`timescale 1ns / 1ps
//`timescale 1us / 1ns
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
    output reg WalkReq
    );
    
    always @ (posedge Sync_WalkReq, posedge WalkReg_Reset) begin
        if (WalkReg_Reset) WalkReq=0;
        if (Sync_WalkReq) WalkReq=1;
    end
    
endmodule
