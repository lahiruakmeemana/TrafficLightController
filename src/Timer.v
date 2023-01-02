//`timescale 1ns / 1ps
`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 10:52:52 AM
// Design Name: 
// Module Name: Timer
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


module Timer(
    input Start_Timer,
    input [3:0] Value,
    input OneHz,
    input clk,
    input Sync_Reset,
    output reg Expired,
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );
    
    reg [3:0] seconds=0;
    reg started = 0;
   
    
    initial begin
        Expired = 0;
    end 
    always @(posedge OneHz) begin 
        if (started) begin
            seconds = seconds+1;
        end
    end
    always @(posedge clk) begin
        if (Start_Timer) begin 
            started=1;
        end
        if ((seconds >= Value)) begin
            Expired = 1;
            started = 0;
            seconds = 0;
            #10 Expired<=0;
        end
        
        if (Sync_Reset) begin
            seconds = 0;
            Expired = 0;
        end
        //if (Expired) #100 Expired<=0;
    end
endmodule
