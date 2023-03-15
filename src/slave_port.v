module slave_port(
    input clk;
    input reset;

	input read_en,
	input write_en,

	input master_ready,
	input master_valid,
	
	output reg slave_valid,
	output slave_ready,

	input rx_address,
	input rx_data,

	output slave_tx_done,
	output rx_done,
	output tx_data,


	input [7:0]datain,
	output [11:0]address,
	output [7:0]data,
	
	output read_en_in,
	output write_en_in);

    

endmodule