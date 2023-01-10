`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 12:02:54 PM
// Design Name: 
// Module Name: FSM
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
// LED sequence  : [Rm,Ym,Gm,Rs,Ys,Gs,Walk]
module FSM(
    input Sync_Sensor,
    input WalkReq,
    input Expired,
    input Sync_Reprogram,
    input Sync_Reset,
    input clk,
    output reg WalkReg_Reset,
    output reg [6:0] LEDs,
    output reg [1:0] Interval,
    output reg Start_Timer
    );
	 
	 		
	reg [2:0] state;
	localparam Gm = 7'b0011000, //Main green
                Ym = 7'b0101000, //Main yellow
                Gs = 7'b1000010, //Side green
                Ys = 7'b1000100, //Side yellow
                Walk = 7'b1001001; //walk
	 
	always @(posedge clk) begin
        Start_Timer = 0;
        if (Sync_Reset | Sync_Reprogram) begin 
            WalkReg_Reset = 1;
            LEDs = Gm;
            Interval = 2'b00;
            
            Start_Timer=1;
            state = 1;
        end
    
        if (Expired) begin
            case (state)
                0: begin            // A 
                    LEDs = Gm;
                    Interval = 2'b00;
                    Start_Timer=1;
                    state = 1;
                   end
                1: begin            // B,  sencond time window
                    LEDs = Gm;
                    if (Sync_Sensor) Interval = 2'b01;
                    else Interval = 2'b00;
                    Start_Timer = 1;
                    state=2;
                   end
                2: begin            // C
                    LEDs = Ym;
                    Interval = 2'b10;
                    Start_Timer = 1;
                    state = 3;
                   end
                3: begin            // D,G
                    if (WalkReq) begin  //G
                        LEDs = Walk;
                        Interval = 2'b01;
                        WalkReg_Reset = 1;
                        Start_Timer = 1;
                        state = 3;
                        end
                    else begin         
                        LEDs = Gs;              //D
                        Interval = 2'b00;
                        Start_Timer = 1;
                        state = 4;
                        WalkReg_Reset = 0;
                    end
                    
                   end
                4: begin  // E,F
                    if (Sync_Sensor) begin          // E
                        LEDs = Gs;
                        Interval = 2'b01;
                        Start_Timer = 1;
                        state = 5;   
                    end else begin                 // F
                        LEDs = Ys;
                        Interval = 2'b10;
                        Start_Timer = 1;
                        state = 0; 
                    end    
                   end
                5: begin            // F
                    LEDs = Ys;
                    Interval = 2'b10;
                    Start_Timer = 1;
                    state = 0; 
                   end
                
                default: begin
                    state=0;
                   end
                   
            endcase
        end
    end
endmodule
