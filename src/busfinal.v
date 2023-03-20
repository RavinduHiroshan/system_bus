module bus(
    input clk,
    input reset,

    input [11:0]address_m1,
    input [7:0]data_m1,
    input [12:0]burst_num_m1,
    input [1:0]slave_select_input_m1,
    input [1:0]instruction_m1,

    input [11:0]address_m2,
    input [7:0]data_m2,
    input [12:0]burst_num_m2,
    input [1:0]slave_select_input_m2,
    input [1:0]instruction_m2,
       
    output tx_done_m1,
    output new_rx_m1,
    output rx_done_m1,
    output [7:0]new_data_m1,

    output new_rx_m2,
    output tx_done_m2,
    output rx_done_m2,
    output [7:0]new_data_m2
);

//Master
wire 
approval_grant_m1,
slave_ready_m1,
slave_valid_m1,
rx_data_m1,
rx_done_from_slave_m1,
approval_request_m1,
master_ready_m1,
master_valid_m1,
tx_address_m1,
tx_data_m1,
tx_burst_m1,
write_enable_m1,
read_enable_m1;

wire 
approval_grant_m2,
slave_ready_m2,
slave_valid_m2,
rx_data_m2,
rx_done_from_slave_m2,
approval_request_m2,
master_ready_m2,
master_valid_m2,
tx_address_m2,
tx_data_m2,
tx_burst_m2,
write_enable_m2,
read_enable_m2;

wire 
busy,
slave_select;

//Arbiter
wire [2:0]slave_grant;
wire [1:0]bus_grant;

//Slave
wire 
read_enable_s1,
write_en_s1,
master_ready_s1,
master_valid_s1,
rx_done_s1,

slave_valid_s1,
slave_ready_s1,

rx_address_s1,
rx_data_s1,
rx_burst_s1,

slave_tx_done_s1,
tx_data_s1;


wire 
read_enable_s2,
write_en_s2,
master_ready_s2,
master_valid_s2,
rx_done_s2,

slave_valid_s2,
slave_ready_s2,

rx_address_s2,
rx_data_s2,
rx_burst_s2,

slave_tx_done_s2,
tx_data_s2;

wire 
read_enable_s3,
write_en_s3,
master_ready_s3,
master_valid_s3,
rx_done_s3,

slave_valid_s3,
slave_ready_s3,

rx_address_s3,
rx_data_s3,
rx_burst_s3,

slave_tx_done_s3,
tx_data_s3;


arbiter arbiter(
    .clk(clk), 
    .reset(reset), 
    .m1_request(approval_request_m1),
    .m2_request(approval_request_m2),  
    .slave_select(slave_select),

    .m1_grant(approval_grant_m1),
    .m2_grant(approval_grant_m2),
    .busy(busy),
    .slave_grant(slave_grant), 
    .bus_grant(bus_grant)   
);

master_port master_port1(
    .clk(clk),
    .reset(reset),
    .address(address_m1),  
    .data(data_m1),           
    .burst_num(burst_num_m1),     
    .slave_select(slave_select_input_m1),    
    .instruction(instruction_m1),   
    .approval_grant(approval_grant_m1),   
    .busy(busy),    
    .slave_ready(slave_ready_m1),
    .slave_valid(slave_valid_m1),                                          //Validate the data transmit by slave
    .rx_data(rx_data_m1), 
    .rx_done_from_slave(rx_done_from_slave_m1),
                             
    .approval_request(approval_request_m1),
    .tx_slave_select(slave_select),
    .master_ready(master_ready_m1),
    .master_valid(master_valid_m1),
    .tx_address(tx_address_m1),
    .tx_data(tx_data_m1),
    .tx_burst_number(tx_burst_m1),
    .tx_done(tx_done_m1),
    .write_en(write_enable_m1),
    .read_en(read_enable_m1),
    .new_rx(new_rx_m1),  
    .rx_done(rx_done_m1),
    .data_input(new_data_m1)

);


master_port master_port2(
    .clk(clk),
    .reset(reset),
    .address(address_m2),  
    .data(data_m2),           
    .burst_num(burst_num_m2),     
    .slave_select(slave_select_input_m2),    
    .instruction(instruction_m2),   
    .approval_grant(approval_grant_m2),   
    .busy(busy),    
    .slave_ready(slave_ready_m2), 
    .slave_valid(slave_valid_m2),  
    .rx_data(rx_data_m2),                                         //Validate the data transmit by slave
    .rx_done_from_slave(rx_done_from_slave_m2),  
                             
    .approval_request(approval_request_m2),
    .tx_slave_select(slave_select),
    .master_ready(master_ready_m2),
    .master_valid(master_valid_m2),
    .tx_address(tx_address_m2),
    .tx_data(tx_data_m2),
    .tx_burst_number(tx_burst_m2),
    .tx_done(tx_done_m2),
    .write_en(write_enable_m2),
    .read_en(read_enable_m2),
    .new_rx(new_rx_m2),  
    .rx_done(rx_done_m2),
    .data_input(new_data_m2)
);


slave slave1(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_enable_s1),
	 .write_en(write_en_s1),

	 .master_ready(master_ready_s1),
	 .master_valid(master_valid_s1),
     .rx_done_in(rx_done_s1),
	
	 .slave_valid(slave_valid_s1),
	 .slave_ready(slave_ready_s1),

	 .rx_address(rx_address_s1),
	 .rx_data(rx_data_s1),
	 .rx_burst(rx_burst_s1),

	 .slave_tx_done(slave_tx_done_s1), 
	 .tx_data(tx_data_s1)
);

slave slave2(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_enable_s2),
	 .write_en(write_en_s2),

	 .master_ready(master_ready_s2),
	 .master_valid(master_valid_s2),
     .rx_done_in(rx_done_s2),
	
	 .slave_valid(slave_valid_s2),
	 .slave_ready(slave_ready_s2),
     
	 .rx_address(rx_address_s2),
	 .rx_data(rx_data_s2),
	 .rx_burst(rx_burst_s2),
	 
     .slave_tx_done(slave_tx_done_s2),
	 .tx_data(tx_data_s2)
);



slave slave3(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_enable_s3),
	 .write_en(write_en_s3),

	 .master_ready(master_ready_s3),
	 .master_valid(master_valid_s3),
     .rx_done_in(rx_done_s3),
	
	 .slave_valid(slave_valid_s3),
	 .slave_ready(slave_ready_s3),

	 .rx_address(rx_address_s3),
	 .rx_data(rx_data_s3),
	 .rx_burst(rx_burst_s3),
	 
     .slave_tx_done(slave_tx_done_s3),   
	 .tx_data(tx_data_s3)
);


master_mux master_mux(
    //Inputs
    .bus_grant(bus_grant), //2bit length
    .slave_grant(slave_grant), //3bit length

    .m1_master_ready(master_ready_m1),
    .m1_master_valid(master_valid_m1),
    .m1_read_en(read_enable_m1),
    .m1_write_en(write_enable_m1),
    .m1_tx_address(tx_address_m1),
    .m1_tx_data(tx_data_m1),
    .m1_tx_burst(tx_burst_m1),
    .m1_tx_done(tx_done_m1),

    .m2_master_ready(master_ready_m2),
    .m2_master_valid(master_valid_m2),
    .m2_read_en(read_enable_m2),
    .m2_write_en(write_enable_m2),
    .m2_tx_address(tx_address_m2),
    .m2_tx_data(tx_data_m2),
    .m2_tx_burst(tx_burst_m2),
    .m2_tx_done(tx_done_m2),


    //Outputs
    .to_slave_master_ready_1(master_ready_s1),
    .to_slave_master_valid_1(master_valid_s1),
    .to_slave_read_en_1(read_enable_s1),
    .to_slave_write_en_1(write_en_s1),
    .to_slave_tx_address_1(rx_address_s1),
    .to_slave_tx_data_1(rx_data_s1),
    .to_slave_tx_burst_1(rx_burst_s1),
    .to_slave_tx_done_1(rx_done_s1),

    .to_slave_master_ready_2(master_ready_s2),
    .to_slave_master_valid_2(master_valid_s2),
    .to_slave_read_en_2(read_enable_s2),
    .to_slave_write_en_2(write_en_s2),
    .to_slave_tx_address_2(rx_address_s2),
    .to_slave_tx_data_2(rx_data_s2),
    .to_slave_tx_burst_2(rx_burst_s2),
    .to_slave_tx_done_2(rx_done_s2),

    .to_slave_master_ready_3(master_ready_s3),
    .to_slave_master_valid_3(master_valid_s3),
    .to_slave_read_en_3(read_enable_s3),
    .to_slave_write_en_3(write_en_s3),
    .to_slave_tx_address_3(rx_address_s3),
    .to_slave_tx_data_3(rx_data_s3),
    .to_slave_tx_burst_3(rx_burst_s3),
    .to_slave_tx_done_3(rx_done_s3)
);


slave_mux slave_mux(
    .slave_grant(slave_grant),
    .bus_grant(bus_grant),

    .slave_valid_1(slave_valid_s1),
    .slave_ready_1(slave_ready_s1),
    .slave_tx_done_1(slave_tx_done_s1),
	.tx_data_1(tx_data_s1),

    .slave_valid_2(slave_valid_s2),
    .slave_ready_2(slave_ready_s2),
    .slave_tx_done_2(slave_tx_done_s2),
	.tx_data_2(tx_data_s2),

    .slave_valid_3(slave_valid_s3),
    .slave_ready_3(slave_ready_s3),
    .slave_tx_done_3(slave_tx_done_s3),
	.tx_data_3(tx_data_s3),

    .slave_valid_m1(slave_valid_m1),
    .slave_ready_m1(slave_ready_m1),
    .slave_tx_done_m1(rx_done_from_slave_m1),
	.tx_data_m1(rx_data_m1),

    .slave_valid_m2(slave_valid_m2),
    .slave_ready_m2(slave_ready_m2),
    .slave_tx_done_m2(rx_done_from_slave_m2),
	.tx_data_m2(rx_data_m2)
);






endmodule