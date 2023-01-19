`timescale 1ns / 1ps
module MasterOut_tb;

    parameter CLOCK_PERIOD  = 4'b1010;

    reg clk, reset, approval_grant, busy, slave_ready, rx_done ;
    reg [11:0]address;                
    reg [7:0]data;                   
    reg [11:0]burst_num;             
    reg [1:0]slave_select;          
    reg [1:0]instruction;                     

    wire approval_request ;
    wire tx_slave_select ;
    wire master_ready ;
    wire master_valid ;
    wire tx_address ;
    wire tx_data ;
    wire tx_burst_number ;
    wire tx_done ;
    wire write_en ;
    wire read_en ;  

    MasterOut MasterOut(
        .approval_request(approval_request) ,
        .tx_slave_select(tx_slave_select) ,
        .master_ready(master_ready) ,
        .master_valid(master_valid) ,
        .tx_address(tx_address) ,
        .tx_data(tx_data) ,
        .tx_burst_number(tx_burst_number) ,
        .tx_done(tx_done) ,
        .write_en(write_en) ,
        .read_en(read_en) 
    );

initial begin
    clk = 0;
    forever begin
        #(CLOCK_PERIOD/2);
        clk <= ~clk;
    end
end

initial begin
    $display($time ,"Starting time of simulation");

    #30     //Read Operation
    instruction <= 2'b11;
    slave_select <= 2'b11;
    address <= 12'd5459;
    burst_num <= 12'd03;

    #20
    busy<=1;

    #20
    busy<=0;
    approval_grant<=1;

    #20
    slave_ready<=1;

    #150
    rx_done<=1;

    #30
    reset<=1;

    #30
    instruction <= 2'b00;
    slave_select <= 2'b00;
    address <= 11'b00;
    burst_num <= 11'd00;
    approval_grant<=0;
    slave_ready<=0;


    #30     //Write Operation
    instruction <= 2'b10 ;
    slave_select <= 2'b10 ;
    address <= 12'd5459 ;
    burst_num <= 12'd00 ;

    #20
    approval_grant<=1;

    #20
    slave_ready<=1;

    #150
    reset<=1;

    #30
    instruction <= 2'b00;
    slave_select <= 2'b00;
    address <= 11'b00;
    burst_num <= 11'd00;
    approval_grant<=0;
    slave_ready<=0;


end
endmodule