`timescale 1ns / 1ps
module MasterIn_tb;

parameter CLOCK_PERIOD  = 4'b1010;
reg clk, reset, slave_valid, rx_data;
//reg tx_done ;
reg [11:0]burst_num ;
reg [1:0]instruction ;
reg approval_grant;

wire rx_done;                                         
wire master_ready;                                    
wire new_rx;
wire [7:0]data ;

MasterIn MasterIn(
    .clk(clk),
    .reset(reset),
    //.tx_done(tx_done),
    .slave_valid(slave_valid),
    .rx_data(rx_data),
    .burst_num(burst_num),
    .instruction(instruction),

    .rx_done(rx_done),
    .master_ready(master_ready),
    .new_rx(new_rx),
    .data(data),
    .approval_grant(approval_grant)
);

initial begin
    clk = 1;
    forever begin
        #(CLOCK_PERIOD/2)
        clk <= ~clk;
    end
end

initial begin
    $display($time ,"Starting time of simulation");

    reset<=0;
    #30
    reset<=1;

    #30                        //Normal Read operation
    reset<=0;
    instruction <= 2'b11;
    burst_num <= 11'd0;
    //tx_done<= 1 ;

    approval_grant <= 1 ;

    #30
    slave_valid<=1;
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;

    #30
    reset <= 1;

    #30
    reset <= 0;
    instruction <= 2'b11;
    slave_valid<=0;

    #30                     //Burst Operation 
    instruction <= 2'b11;
    burst_num <= 11'd3;
    //tx_done<= 1 ;

    #30
    slave_valid<=1;
    approval_grant <= 1 ;

    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=0;

    #10
    rx_data<=0;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;

    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=1;
    #10
    rx_data<=0;
    #10
    rx_data<=1;
    #10
    rx_data<=1;

    #30
    reset <= 1;

    $display($time ,"End time of simulation");
    $stop;
end

endmodule