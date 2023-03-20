module slave_mux(
    input [2:0]slave_grant,
    input [1:0]bus_grant,
    
    input slave_valid_1,
    input slave_ready_1,
    input slave_tx_done_1,
	//input rx_done_1,
	input tx_data_1,


    input slave_valid_2,
    input slave_ready_2,
    input slave_tx_done_2,
	//input rx_done_2,
	input tx_data_2,

    input slave_valid_3,
    input slave_ready_3,
    input slave_tx_done_3,
	//input rx_done_3,
	input tx_data_3,

    output slave_valid_m1,
    output slave_ready_m1,
    output slave_tx_done_m1,
	//output rx_done_m1,
	output tx_data_m1,


    output slave_valid_m2,
    output slave_ready_m2,
    output slave_tx_done_m2,
	//output rx_done_m2,
	output tx_data_m2

);

//master 1  
assign slave_valid_m1   =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? slave_valid_1:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? slave_valid_2:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? slave_valid_3: 1'b0;

assign slave_ready_m1   =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? slave_ready_1:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? slave_ready_2:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? slave_ready_3: 1'b0;

assign slave_tx_done_m1 =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? slave_tx_done_1:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? slave_tx_done_2:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? slave_tx_done_3: 1'b0;

// assign rx_done_m1       =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? rx_done_1:
//                             ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? rx_done_2:
//                             ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? rx_done_3: 1'b0;

assign tx_data_m1       =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? tx_data_1:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? tx_data_2:
                            ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? tx_data_3: 1'b0;


//master 2  
assign slave_valid_m2   =   ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? slave_valid_1:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? slave_valid_2:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? slave_valid_3: 1'b0;

assign slave_ready_m2   =   ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? slave_ready_1:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? slave_ready_2:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? slave_ready_3: 1'b0;

assign slave_tx_done_m2 =   ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? slave_tx_done_1:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? slave_tx_done_2:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? slave_tx_done_3: 1'b0;

// assign rx_done_m2       =   ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? rx_done_1:
//                             ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? rx_done_2:
//                             ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? rx_done_3: 1'b0;

assign tx_data_m2       =   ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? tx_data_1:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? tx_data_2:
                            ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? tx_data_3: 1'b0;


endmodule