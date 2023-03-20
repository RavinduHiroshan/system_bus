`timescale 1ns / 1ps
module command_processor_tb;

reg [7:0]data_stream  = 8'b10101010;
reg [7:0]data_stream2 = 8'b01100010;


command_processor command_processor(
    input clk,
    input reset,

    input [7:0]switch1,
    input button1,
    input button2,
    input button3,

    output reg[1:0]data_read_m1,
    output reg[1:0]data_read_m2,
    output reg[1:0]data_write,                     

);

initial begin
    clk = 1;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end

//wirte Operation

#(CLOCK_PERIOD)
reset <=1 ;

#(CLOCK_PERIOD)
reset <=0;

#(CLOCK_PERIOD*2)
button1<= 1 ;

#(CLOCK_PERIOD*2)
switch1 <= data_stream ;

#(CLOCK_PERIOD*2)
button2 <= 1;

#(CLOCK_PERIOD*2)
button1<=0;
button1<=0;

//Read Operation
#(CLOCK_PERIOD)
reset <=1 ;

#(CLOCK_PERIOD)
reset <=0;

#(CLOCK_PERIOD*2)
button1<= 1 ;

#(CLOCK_PERIOD*2)
switch1 <= data_stream2 ;

#(CLOCK_PERIOD*2)
button2 <= 1;

#(CLOCK_PERIOD*2)
button1<=0;
button1<=0;


endmodule