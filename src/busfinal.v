module bus(
    input clk,
    input reset,

    input [1:0]slave_select_input_m1,
    input [11:0]address_m1,
    input [7:0]data_m1,
    input [12:0]burst_num_m1,
    input [1:0]instruction_m1,

    output [7:0]new_data_m1,
    output new_rx_m1,

    input [1:0]slave_select_input_m2,
    input [11:0]address_m2,
    input [7:0]data_m2,
    input [12:0]burst_num_m2,
    input [1:0]instruction_m2,

    output [7:0]new_data_m2,
    output new_rx_m2,

);

wire master_ready_m1,
master_valid_m1,
tx_address_m1,
tx_data_m1,
tx_burst_m1,
write_enable_m1,
read_enable_m1,
approval_request_m1,
slave_select_m1
approval_grant_m1,

wire master_ready_m2,
master_valid_m2,
tx_address_m2,
tx_data_m2,
tx_burst_m2,
write_enable_m2,
read_enable_m2,
approval_request_m2,
slave_select_m2,
approval_grant_m2,

wire busy_m1, //discuss
slave_ready_mux,
slave_valid_mux,
rx_data_mux,

// wire master_ready_m1,
// rx_done_m1,
// wire master_ready_m2,
// rx_done_m2,

wire slave_valid_s1,
slave_ready_s1,
tx_data_s1,

wire slave_valid_s2,
slave_ready_s2,
tx_data_s2,

wire slave_valid_s3,
slave_ready_s3,
tx_data_s3,

master_port master_port1(
     .clk(clk),
    .reset(reset),
    .address(),  
    .data(),           
    .burst_num(),     
    .slave_select(),    
    .instruction(),   
    .approval_grant(),   
    .busy(),    
    .slave_ready(), 
                             
    .approval_request(),
    .tx_slave_select(),
    .master_ready(),
    .master_valid(),
    .tx_address(),
    .tx_data(),
    .tx_burst_number(),
    .tx_done(),
    .write_en(),
    .read_en(),

    .slave_valid(),                                          //Validate the data transmit by slave
    .rx_data(),                                              //Data from the slave
    .new_rx(),  
    .rx_done(),
    .data_input(),



);










endmodule