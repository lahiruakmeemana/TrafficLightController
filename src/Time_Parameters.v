`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 07:00:16 PM
// Design Name: 
// Module Name: Time_Parameters
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


module Time_Parameters(
    input Sync_Reprogram,
    input Sync_Reset,
    input [1:0] Selector,
    input [3:0] Time_Value,
    input [1:0] Interval,
    input clk,
    output reg [3:0] Value
    );
    
    reg[3:0] tBase = 4'b0110;   //00
    reg[3:0] tExt = 4'b0011;    //01
    reg[3:0] tYel = 4'b0010;    //10
    
    always @(posedge clk) begin
    
        case (Interval)
            2'b00: Value = tBase;
            2'b01: Value = tExt;
            2'b10: Value = tYel;
        endcase
        
        if (Sync_Reprogram) begin
            case (Selector)
                2'b00: tBase = Time_Value;
                2'b01: tExt = Time_Value;
                2'b10: tYel = Time_Value;
            endcase
        end
        
        if (Sync_Reset) begin
            tBase = 4'b0110;  //00
            tExt = 4'b0011;   //01
            tYel = 4'b0010;   //10
        end
    end
    
endmodule
