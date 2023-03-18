`timescale 1ns / 1ps

module slave(
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
	input rx_burst,
	output slave_tx_done,
	output rx_done,
	output tx_data
	);

	wire [0:11]address;
	wire [0:7]datain;
	wire data_ready = rx_done & write_en;
	wire [0:7]data;
	wire enable = read_en | write_en;
	slave_port slave_port(
		.clk(clk),
		.reset(reset),
		
		.read_en(read_en),
		.write_en(write_en),

		.master_ready(master_ready),
		.master_valid(master_valid),
		
		.slave_valid(slave_valid),
		.slave_ready(slave_ready),

		.rx_address(rx_address),
		.rx_data(rx_data),
		.rx_burst(rx_burst),

		.slave_tx_done(slave_tx_done),
		.rx_done(rx_done),
		.tx_data(tx_data),

		.data_ready(data_ready),
		.datain(datain),
		.address(address),
		.data(data)
	);

	ram_wrapper ram_wrapper(
		.BRAM_PORTA_0_addr(address),
		.BRAM_PORTA_0_clk(clk),
		.BRAM_PORTA_0_din(data),
		.BRAM_PORTA_0_en(enable),
		.BRAM_PORTA_0_rst(reset),
		.BRAM_PORTA_0_we(rx_done),

		.BRAM_PORTA_0_dout(datain),
		.rsta_busy_0()
	);

    
endmodule
