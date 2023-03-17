`timescale 1ns / 1ps
module Master_tb;

parameter CLOCK_PERIOD  = 4'b1010;

    reg clk, reset,
  
    //Inputs and output from master out port
    reg [ADDR_LEN-1:0]address,                //From switches
    reg [DATA_LEN-1:0]data,                   //From switches
    reg [BURST_LEN-1:0]burst_num,             //From switches
    reg [SLAVE_LEN-1:0]slave_select,          //From switches
    reg [1:0]instruction,                     //For initialize the transaction
    reg approval_grant,                       //From arbitor
    reg busy,                                 //From arbitor (If other master is occupied busy == 1)    
    reg slave_ready,                          //From Slave
    // input rx_done,                              //From Master In

    wire approval_request,
    wire tx_slave_select,
    wire master_ready,
    wire master_valid,
    wire tx_address,
    wire tx_data,
    wire tx_burst_number,
    wire tx_done,
    wire write_en,
    wire read_en,

    //Inputs and outputs from master in port
    reg slave_valid,                                          //Validate the data transmit by slave
    reg rx_data,                                              //Data from the slave
    
    //output reg rx_done,                                       //Output signal to master out when after the rx done
    wire  master_ready,                                    //Master ready signal to slave
    wire  new_rx,                                          //Output signal about new data 
    wire  [DATA_LEN-1:0]data                               

Master Master(
    .clk(clk),
    .reset(reset),
    .address(address),
    .data(data),
    .burst_num(burst_num),
    .slave_select(slave_select),
    .instruction(instruction),
    .approval_grant(approval_grant),
    .busy(busy),
    .slave_ready(slave_ready),

    .approval_request(approval_request),
    .tx_slave_select(tx_slave_select),
    .master_ready(master_ready),
    .master_valid(master_valid),
    .tx_address(tx_address),
    .tx_data(tx_data),
    .tx_burst_number(tx_burst_number),
    .tx_done(tx_done),
    .write_en(write_en),
    .read_en(read_en),

    .slave_valid(slave_valid),
    .rx_data(rx_data),
  
    .master_ready(master_ready),
    .new_rx(new_rx),
    .data(data)

);

initial begin
    clk = 0;
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


    reset<=0;
    #30                        //Normal Read operation
    instruction <= 2'b11;
    burst_num <= 11'd0;



    $display($time ,"End time of simulation");
    $stop;
end

endmodule