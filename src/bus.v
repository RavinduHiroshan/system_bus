module bus(
    
);

reg clk, reset, slave_select_input_1;


reg instruction_m1,
address_m1,
data_m1,
burst_num_m1,

instruction_m2,
address_m2,
data_m2,
burst_num_m2;

wire master_ready_s3,
master_valid_s3,
read_en_s3,
write_en_s3,
rx_address_s3,
rx_data_s3,
rx_burst_s3,

master_ready_s2,
master_valid_s2,
read_en_s2,
write_en_s2,
rx_address_s2,
rx_data_s2,
rx_burst_s2,

master_ready_s1,
master_valid_s1,
read_en_s1,
write_en_s1,
rx_address_s1,
rx_data_s1,
rx_burst_s1,

approval_grant_m1,
approval_grant_m2,
slave_select,
m1_grant,
m2_grant,
busy,
slave_grant,
bus_grant,

master_ready_m2,
master_valid_m2,
tx_address_m2,
tx_data_m2,
tx_burst_number_m2,

master_ready_m1,
master_valid_m1,
tx_address_m1,
tx_data_m1,
tx_burst_number_m1,

slave_valid_m1,
slave_valid_m2,
rx_data_m1,
rx_data_m2,
tx_done_m1,
tx_done_m2,

master_rx_done_s1,
master_rx_done_s2,
master_rx_done_s3;






arbiter arbiter(
    .clk(clk), // system clock
    .reset(reset), // system reset
    .m1_request(approval_grant_m1),   // Mster 1 request, it should be high during master 1 transactions.
    .m2_request(approval_grant_m2),  
    .slave_select(slave_select),

    .m1_grant(m1_grant),
    .m2_grant(m2_grant),
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
    .slave_select(slave_select_input_1),    
    .instruction(instruction_m1),   
    .approval_grant(approval_grant_m1),   
    .busy(busy),    
    .slave_ready(slave_ready_m1),                       
    //.rx_done(rx_done_m1),                             
    
    .approval_request(m1_grant),
    .tx_slave_select(slave_select),
    .master_ready(master_ready_m1),
    .master_valid(master_valid_m1),
    .tx_address(tx_address_m1),
    .tx_data(tx_data_m1),
    .tx_burst_number(tx_burst_number_m1),
    .tx_done(tx_done_m1),
    .write_en(write_en_m1),
    .read_en(read_en_m1),

    .slave_valid(slave_valid_m1),                                          //Validate the data transmit by slave
    .rx_data(rx_data_m1),                                              //Data from the slave
    .new_rx(new_rx_m1)  
);

master_port master_port2(
    .clk(clk),
    .reset(reset),
    .address(address_m2),  
    .data(data_m2),           
    .burst_num(burst_num_m2),     
    .slave_select(slave_select),    
    .instruction(instruction_m2),   
    .approval_grant(approval_grant_m2),   
    .busy(busy),    
    .slave_ready(slave_ready_m2),                       
    //.rx_done(rx_done_m2),                             
    
    .approval_request(m2_grant),
    .tx_slave_select(tx_slave_select_m2),
    .master_ready(master_ready_m2),
    .master_valid(master_valid_m2),
    .tx_address(tx_address_m2),
    .tx_data(tx_data_m2),
    .tx_burst_number(tx_burst_number_m2),
    .tx_done(tx_done_m2),
    .write_en(write_en_m2),
    .read_en(read_en_m2),

    .slave_valid(slave_valid_m2),                                          //Validate the data transmit by slave
    .rx_data(rx_data_m2),                                              //Data from the slave
    .new_rx(new_rx_m2)  
);

slave slave1(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_en_s1),
	 .write_en(write_en_s1),

	 .master_ready(master_ready_s1),
	 .master_valid(master_valid_s1),
     .rx_done_in(master_rx_done_s1),
	
	 .slave_valid(slave_valid_s1),
	 .slave_ready(slave_ready_s1),
	 .rx_address(rx_address_s1),
	 .rx_data(rx_data_s1),
	 .rx_burst(rx_burst_s1),
	 //.slave_tx_done(slave_tx_done_s1),
	 //.rx_done(rx_done_s1),
	 .tx_data(tx_data_s1)
);

slave slave2(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_en_s2),
	 .write_en(write_en_s2),

	 .master_ready(master_ready_s2),
	 .master_valid(master_valid_s2),
     .rx_done_in(master_rx_done_s2),
	
	 .slave_valid(slave_valid_s2),
	 .slave_ready(slave_ready_s2),
	 .rx_address(rx_address_s2),
	 .rx_data(rx_data_s2),
	 .rx_burst(rx_burst_s2),
	 //.slave_tx_done(slave_tx_done_s2),
	 //.rx_done(rx_done_s2),
	 .tx_data(tx_data_s2)
);


slave slave3(
     .clk(clk),
     .reset(reset),
    
	 .read_en(read_en_s3),
	 .write_en(write_en_s3),

	 .master_ready(master_ready_s3),
	 .master_valid(master_valid_s3),
     .rx_done_in(master_rx_done_s3),
	
	 .slave_valid(slave_valid_s3),
	 .slave_ready(slave_ready_s3),
	 .rx_address(rx_address_s3),
	 .rx_data(rx_data_s3),
	 .rx_burst(rx_burst_s3),
	 //.slave_tx_done(slave_tx_done_s3),
	 //.rx_done(rx_done_s3),
	 .tx_data(tx_data_s3)
);



master_mux master_mux(
    .bus_grant(bus_grant),
    .slave_grant(slave_grant),

    .m1_master_ready(master_ready_m1),
    .m1_master_valid(master_valid_m1),
    .m1_read_en(read_en_m1),
    .m1_write_en(write_en_m1),
    .m1_tx_address(tx_address_m1),
    .m1_tx_data(tx_data_m1),
    .m1_tx_burst(tx_burst_number_m1),
    .m1_tx_done(tx_done_m1),

    .m2_master_ready(master_ready_m2),
    .m2_master_valid(master_valid_m2),
    .m2_read_en(read_en_m2),
    .m2_write_en(write_en_m2),
    .m2_tx_address(tx_address_m2),
    .m2_tx_data(tx_data_m2),
    .m2_tx_burst(tx_burst_number_m2),
    .m2_tx_done(tx_done_m2),
    
    .to_slave_master_ready_1(master_ready_s1),
    .to_slave_master_valid_1(master_valid_s1),
    .to_slave_read_en_1(read_en_s1),
    .to_slave_write_en_1(write_en_s1),
    .to_slave_tx_address_1(rx_address_s1),
    .to_slave_tx_data_1(rx_data_s1),
    .to_slave_tx_burst_1(rx_burst_s1),
    .to_slave_tx_done_1(master_rx_done_s1),

    .to_slave_master_ready_2(master_ready_s2),
    .to_slave_master_valid_2(master_valid_s2),
    .to_slave_read_en_2(read_en_s2),
    .to_slave_write_en_2(write_en_s2),
    .to_slave_tx_address_2(rx_address_s2),
    .to_slave_tx_data_2(rx_data_s2),
    .to_slave_tx_burst_2(rx_burst_s2),
    .to_slave_tx_done_2(master_rx_done_s2),

    .to_slave_master_ready_3(master_ready_s3),
    .to_slave_master_valid_3(master_valid_s3),
    .to_slave_read_en_3(read_en_s3),
    .to_slave_write_en_3(write_en_s3),
    .to_slave_tx_address_3(rx_address_s3),
    .to_slave_tx_data_3(rx_data_s3),
    .to_slave_tx_done_3(master_rx_done_s3),
    .to_slave_tx_burst_3(rx_burst_s3)
);

slave_mux slave_mux(
    .slave_grant(slave_grant),
    .bus_grant(bus_grant),

    .slave_valid_1(slave_valid_s1),
    .slave_ready_1(slave_ready_s1),
    //.slave_tx_done_1(slave_tx_done_s1),
	//.rx_done_1(rx_done_s1),
	.tx_data_1(tx_data_s1),


    .slave_valid_2(slave_valid_s2),
    .slave_ready_2(slave_ready_s2),
    //.slave_tx_done_2(slave_tx_done_s2),
	//.rx_done_2(rx_done_s2),
	.tx_data_2(tx_data_s2),

    .slave_valid_3(slave_valid_s3),
    .slave_ready_3(slave_ready_s3),
    //.slave_tx_done_3(slave_tx_done_s3),
	//.rx_done_3(rx_done_s3),
	.tx_data_3(tx_data_s3),

    .slave_valid_m1(slave_valid_m1),
    .slave_ready_m1(slave_ready_m1),
    //.slave_tx_done_m1(slave_tx_done_m1),
	//.rx_done_m1(rx_done_m1),
	.tx_data_m1(rx_data_m1),


    .slave_valid_m2(slave_valid_m2),
    .slave_ready_m2(slave_ready_m2),
    //.slave_tx_done_m2(slave_tx_done_m2),
	//.rx_done_m2(rx_done_m2),
	.tx_data_m2(rx_data_m2)
);

    
endmodule