module master_port(
    input clk,
    input reset,
    input [ADDR_LEN-1:0]address,                //From switches
    input [DATA_LEN-1:0]data,                   //From switches
    input [BURST_LEN-1:0]burst_num,             //From switches
    input [SLAVE_LEN-1:0]slave_select,          //From switches
    input [1:0]instruction,                     //For initialize the transaction
    input approval_grant,                       //From arbitor
    input busy,                                 //From arbitor (If other master is occupied busy == 1)    
    input slave_ready,                          //From Slave
    input rx_done,                              //From Master In
    
    output reg approval_request,
    output reg tx_slave_select,
    output reg master_ready,
    output reg master_valid,
    output reg tx_address,
    output reg tx_data,
    output reg tx_burst_number,
    output reg tx_done,
    output reg write_en,
    output reg read_en

    //input tx_done,                                            //Signal from slave after finish a transaction
    input slave_valid,                                          //Validate the data transmit by slave
    input rx_data,                                              //Data from the slave
    output reg new_rx,                                          //Output signal about new data 
);


    
endmodule