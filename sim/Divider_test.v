`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 10:20:54 AM
// Design Name: 
// Module Name: Divider_test
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


module Divider_test;

reg clk;
reg Sync_Reset;
wire OneHz;

Divider uut(
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .OneHz(OneHz)
);
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end
initial begin
    #15000
    Sync_Reset = 1;
    #150
    Sync_Reset = 0;
end
    

endmodule
