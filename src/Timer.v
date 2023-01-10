`timescale 1ns / 1ps
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
    input [3:0] Value,
    input OneHz,
    input Start_Timer,
	input clk,
	input Sync_Reset,
    output reg Expired,
    output reg [3:0] Anode_Activate,
    output reg [6:0] LED_out
    );
	 
    // for 7seg display
	reg [15:0] displayed_number;
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter;
    wire [1:0] LED_activating_counter;
    
	reg [3:0] seconds=0;
	reg started =1; 
	reg OneHz_checked = 0;
	always @(posedge clk) begin
        if (Start_Timer) begin 
            started=1;
        end
        if (started & OneHz) begin
            if (!OneHz_checked) begin
                seconds = seconds+1;
                OneHz_checked = 1;
            end
        end if (!OneHz) OneHz_checked=0;
        Expired=0;
        if (seconds >= Value) begin
            Expired = 1;
            started = 0;
            seconds = 0;
        end
        
        if (Sync_Reset) begin
            seconds = 0;
            Expired = 0;
        end
    end 
    
    always @(posedge clk or posedge Sync_Reset)
    begin 
        if(Sync_Reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            LED_BCD = 0;
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            LED_BCD = seconds;
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            LED_BCD = 0;
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            LED_BCD = Value;
               end
        endcase
    end
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end			
endmodule