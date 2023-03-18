module master_port#(parameter SLAVE_LEN=2, parameter ADDR_LEN=12, parameter DATA_LEN=8, parameter BURST_LEN=12)(
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
    
    output  approval_request,
    output tx_slave_select,
    output master_ready,
    output master_valid,
    output tx_address,
    output tx_data,
    output tx_burst_number,
    output tx_done,
    output write_en,
    output read_en,

    //input tx_done,                                            //Signal from slave after finish a transaction
    input slave_valid,                                          //Validate the data transmit by slave
    input rx_data,                                              //Data from the slave
    output new_rx                                         //Output signal about new data 
);

master_out master_out(
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
    .rx_done(rx_done),                              
    
    .approval_request(approval_request),
    .tx_slave_select(tx_slave_select),
    .master_ready(master_ready),
    .master_valid(master_valid),
    .tx_address(tx_address),
    .tx_data(tx_data),
    .tx_burst_number(tx_burst_number),
    .tx_done(tx_done),
    .write_en(write_en),
    .read_en(read_en)
);

master_in master_in(
     .clk(clk),
     .reset(reset),
     .slave_valid(slave_valid),                                       
     .rx_data(rx_data),                                             
     .burst_num(burst_num),                            
     .instruction(instruction),                                    
     .approval_grant(approval_grant),                      
    
      .rx_done(rx_done),              
      .master_ready(master_ready),              
      .new_rx(new_rx),                                  
      .data(data)         
);


    
endmodule