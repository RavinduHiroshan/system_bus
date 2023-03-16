module slave_port(
    input clk,
    input reset,
    
	input read_en,
	input write_en,

	input master_ready,
	input master_valid,
	
	output slave_valid,
	output slave_ready,

	input rx_address,
	input rx_data,

	output slave_tx_done,
	output rx_done,
	output tx_data,

	input data_ready,
	input [7:0]datain,
	output [11:0]address,
	output [7:0]data
	);



	slave_in_port slave_in(
		.clk(clk), 
		.reset(reset),
		.rx_address(rx_address),  // rx_address bring address to module seraliy
		.rx_data(rx_data),  // rx_data bring data to module seraliy
		.master_valid(master_valid), // check validity of master
		.master_ready(master_ready),
		.read_en(read_en),
		.write_en(write_en),
		.rx_burst(rx_burst),

		.slave_ready(slave_ready),
		.rx_done(rx_done),

		.address(address), // output to the module
		.data(data) // output to the module
	);

	slave_out_port slave_out(
		.clk(clk), 
		.reset(reset),
		.master_ready(master_ready),
		.datain(datain),
		.data_ready(data_ready),
		
		.slave_tx_done(slave_tx_done),
		.tx_data(tx_data)
		
	);

    

endmodule