`timescale 1ns / 1ps
module command_processor_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk, reset ;
reg [7:0] switch1 ;
reg button1;
reg button2;
reg button3;

wire [1:0]data_read_m1;
wire [1:0]data_read_m2;
wire [1:0]data_write;

reg [7:0]data_stream  = 8'b10101010;
reg [7:0]data_stream2 = 8'b01100010;


command_processor command_processor(
    .clk(clk),
    .reset(reset),

    .switch1(switch1),
    .button1(button1),
    .button2(button2),
    .button3(button3),

    .data_read_m1(data_read_m1),
    .data_read_m2(data_read_m2),
    .data_write(data_write),                     

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