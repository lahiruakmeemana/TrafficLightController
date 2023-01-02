`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 06:20:10 PM
// Design Name: 
// Module Name: WalkReg_test
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


module WalkReg_test;

reg Sync_WalkReq;
reg WalkReg_Reset;

wire WalkReq;

WalkReg uut(
    .Sync_WalkReq(Sync_WalkReq),
    .WalkReg_Reset(WalkReg_Reset),
    .WalkReq(WalkReq)
);
initial begin
    Sync_WalkReq=0;
    WalkReg_Reset=0;
    
    #100
    Sync_WalkReq=1;
    #10
    Sync_WalkReq=0;
    
    #300
    WalkReg_Reset=1;
    #10
    WalkReg_Reset=0;
end
endmodule
