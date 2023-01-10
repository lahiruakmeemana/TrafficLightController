`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 11:20:23 AM
// Design Name: 
// Module Name: Timer_test
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


module Timer_test;

reg Start_Timer;
reg [3:0] Value;
reg OneHz;
reg clk;
reg Sync_Reset;
wire Expired;
wire Anode_Activate;
wire [6:0] LED_out;
Timer uut(
    .Start_Timer(Start_Timer),
    .Value(Value),
    .OneHz(OneHz),
    .clk(clk),
    .Sync_Reset(Sync_Reset),
    .Expired(Expired),
    .Anode_Activate(Anode_Activate),
    .LED_out(LED_out)
    
);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end

initial begin
    Value = 3;
    OneHz = 0;
    Start_Timer = 1;
    #60 Start_Timer <= 0;
    Sync_Reset=0;
    #500000
    OneHz = 1;
    #500000
    OneHz=0;
    #500000
    OneHz = 1;
    #500000
    OneHz = 0;
    #500000
    OneHz = 1;
    #500000
    OneHz = 0;
    #500000
    OneHz = 1;
    #500000
    OneHz = 0;
    #500000
    OneHz = 1;
    #500000
    OneHz = 0;
    
    
end

endmodule
