module command_processor_tb;

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

endmodule