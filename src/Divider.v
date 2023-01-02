//`timescale 1ns / 1ps
`timescale 1us / 1ns
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
/*
    reg [26:0] counter = 0;
    initial begin
        OneHz = 1;
    end
    always @(posedge clk) begin
        counter = counter +1;
        if (counter == 50000) begin //50000 for us
            OneHz = ~OneHz;
            counter = 0;
        end    
        if (Sync_Reset) counter=0;
    end
    */
    
    parameter MAX_COUNT = 100_000_000 -1;
    wire counter_en;
    reg [26:0] counter_100M;
    initial begin OneHz=1;
    end
        
    always @(posedge clk, posedge Sync_Reset)
        if (Sync_Reset) counter_100M <=0;
        else if (counter_100M == MAX_COUNT) begin
            counter_100M <=0;
            OneHz = ~OneHz; end
        else counter_100M <= counter_100M + 1'b1;
    
endmodule