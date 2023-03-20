`timescale 1ns / 1ps
module bus_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk;



initial begin
    clk <= 0;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end

reg reset;

reg [11:0]address_m1=0;
reg [7:0]data_m1=0;
reg [12:0]burst_num_m1=0;
reg [1:0]slave_select_input_m1=0;
reg [1:0]instruction_m1=0;

reg [11:0]addressm2=0;
reg [7:0]datam2=0;
reg [12:0]burst_numm2=0;
reg [1:0]slave_select_inputm2=0;
reg [1:0]instructionm2=0;


wire tx_done_m1;
wire new_rx_m1;
wire rx_done_m1;
wire [7:0]new_data_m1;

wire new_rx_m2;
wire tx_done_m2;
wire rx_done_m2;
wire [7:0]new_data_m2;





bus bus(
    .clk(clk),
    .reset(reset),

    .address_m1(address_m1), // 12 bit address
    .data_m1(data_m1),   //8bit
    .burst_num_m1(burst_num_m1),
    .slave_select_input_m1(slave_select_input_m1),
    .instruction_m1(instruction_m1),

    .address_m2(address_m2),
    .data_m2(data_m2),
    .burst_num_m2(burst_num_m2),
    .slave_select_input_m2(slave_select_input_m2),
    .instruction_m2(instruction_m2),
       
    .tx_done_m1(tx_done_m1),
    .new_rx_m1(new_rx_m1),
    .rx_done_m1(rx_done_m1),
    .new_data_m1(new_data_m1),

    .new_rx_m2(new_rx_m2),
    .tx_done_m2(tx_done_m2),
    .rx_done_m2(rx_done_m2),
    .new_data_m2(new_data_m2)
);


initial begin
    reset <= 0;
    #CLOCK_PERIOD
    address_m1 <= 12'b101010010101;
    data_m1 <=  8'b10111101;
    burst_num_m1 <= 0;
    slave_select_input_m1 <= 2'd2;
    instruction_m1 <= 2'd2;
end

initial begin
    forever begin
        #CLOCK_PERIOD
        if(tx_done_m1)begin
            
            instruction_m1 <= 0;
            #(CLOCK_PERIOD*5)
            instruction_m1 <= 2'd3;
        end
    end
end


endmodule