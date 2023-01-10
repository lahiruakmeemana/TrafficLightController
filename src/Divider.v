`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 08:52:40 PM
// Design Name: 
// Module Name: Divider
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
module Divider(
    input clk,
	 input Sync_Reset,
    output reg OneHz
    );
	
    parameter MAX_COUNT = 50_000_000 - 1;//50_000_000 -1;
    wire counter_en;
    reg [28:0] counter_100M=0;
    initial begin OneHz=1;
    end
        
    always @(posedge clk, posedge Sync_Reset)
        if (Sync_Reset) counter_100M <=0;
        else if (counter_100M == MAX_COUNT) begin
            counter_100M <=0;
            OneHz = ~OneHz; end
        else counter_100M <= counter_100M + 1'b1;

endmodule
