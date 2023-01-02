//`timescale 1ns / 1ps
`timescale 1us / 1ns
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


module FSM(
    input Sync_Sensor,
    input WalkReq,
    input Sync_Reprogram,
    input Expired,
    input clk,
    input Sync_Reset,
    output reg Start_Timer,
    output reg [1:0] Interval,
    output reg WalkReg_Reset,
    output reg [6:0] LEDs,       // Rm,Ym,Gm,Rs,Ys,Gs,Walk
    output reg [2:0] state,       // Next state
    output reg WALK_REQ
    );
    
   // reg state = 0;
    localparam Gm = 7'b0011000,
               Ym = 7'b0101000,
               Gs = 7'b1000010,
               Ys = 7'b1000100,
               Walk = 7'b1001001;
               
    initial begin;
        WalkReg_Reset = 0;
        LEDs = Gm;
        Interval = 2'b00;
        state=0;
        #5
        Start_Timer=1;
        state = 1;
        #15 Start_Timer <= 0;
    end
    /*
    always @(posedge clk) begin
        #40 Start_Timer <= 0;
        #40 WalkReg_Reset = 0;
    end
    */
    //always @(posedge Expired, posedge Sync_Reset,posedge Sync_Reprogram) begin
    always @(posedge clk) begin
        //Start_Timer = 0;
        WALK_REQ <= WalkReq;
        if (Sync_Reset | Sync_Reprogram) begin 
            WalkReg_Reset = 1;
            #5 LEDs = Gm;
            Interval = 2'b00;
            #5
            Start_Timer=1;
            state = 1;
            #15 Start_Timer <= 0;
        end
    
        if (Expired) begin
            //#50 Start_Timer <= 0;
            case (state)
                0: begin            // A 
                    LEDs = Gm;
                    Interval = 2'b00;
                    Start_Timer=1;
                    state = 1;
                    #15 Start_Timer <= 0;
                   end
                1: begin            // B,  sencond time window
                    LEDs = Gm;
                    if (Sync_Sensor) Interval = 2'b01;
                    else Interval = 2'b00;
                    Start_Timer = 1;
                    //if (WalkReq) state = 6;
                    //else state = 2;
                    state=2;
                    #15 Start_Timer <= 0;
                   end
                2: begin            // C
                    LEDs = Ym;
                    Interval = 2'b10;
                    Start_Timer = 1;
                    state = 3;
                    #15 Start_Timer <= 0;
                   end
                3: begin            // D,G
                    if (WalkReq) begin  //G
                        LEDs = Walk;
                        Interval = 2'b01;
                        WalkReg_Reset = 1;
                        Start_Timer = 1;
                        state = 3;
                        #15 Start_Timer <= 0;
                        #15 WalkReg_Reset<=0; end
                    else begin         
                        LEDs = Gs;              //D
                        Interval = 2'b00;
                        Start_Timer = 1;
                        state = 4;
                        #15 Start_Timer <= 0;
                    end
                    
                   end
                4: begin  // E,F 
                    if (Sync_Sensor) begin          // E
                        LEDs = Gs;
                        Interval = 2'b01;
                        Start_Timer = 1;
                        state = 5;   
                        #15 Start_Timer <= 0;      
                    end else begin                 // F
                        LEDs = Ys;
                        Interval = 2'b10;
                        Start_Timer = 1;
                        state = 0; 
                        #15 Start_Timer <= 0;
                    end    
                   end
                5: begin            // F
                    LEDs = Ys;
                    Interval = 2'b10;
                    Start_Timer = 1;
                    state = 0; 
                    #15 Start_Timer <= 0;           
                   end
                
                default: begin
                    state=0;
                   end
                   
            endcase
        end
    end   
    
endmodule
