`timescale 1us / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2022 07:44:45 PM
// Design Name: 
// Module Name: Time_Parameters_test
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


module Time_Parameters_test;

reg Sync_Reprogram;
reg Sync_Reset;
reg [1:0] Selector;
reg [3:0] Time_Value;
reg [1:0] Interval;
reg clk;

wire [3:0] Value;

Time_Parameters uut(
    .Sync_Reprogram(Sync_Reprogram),
    .Sync_Reset(Sync_Reset),
    .Selector(Selector),
    .Time_Value(Time_Value),
    .Interval(Interval),
    .clk(clk),
    .Value(Value)
);

initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end 
end

initial begin
    Selector = 2'b00;
    Time_Value = 4'b0000;
    Sync_Reprogram = 0;
    Sync_Reset = 0;
    Interval=2'b00;
    
    #100
    Interval= 2'b01;
    #75
    Interval = 2'b10;
    #50;
    
    #100
    Sync_Reprogram = 1;
    #5
    Selector = 2'b01;
    Time_Value = 4'b0101;
    Interval = 2'b01;
    #55
    Sync_Reprogram = 0;
    
    #150
    Sync_Reset = 1;
    #60
    Sync_Reset = 0;
     
end
    

endmodule
