module master_mux(
    input [1:0]bus_grant,
    input [2:0]slave_grant,

    input m1_master_ready,
    input m1_master_valid,
    input m1_read_en,
    input m1_write_en,
    input m1_tx_address,
    input m1_tx_data,
    input m1_tx_burst,
    input m1_tx_done,

    input m2_master_ready,
    input m2_master_valid,
    input m2_read_en,
    input m2_write_en,
    input m2_tx_address,
    input m2_tx_data,
    input m2_tx_burst,
    input m2_tx_done,
    
    output to_slave_master_ready_1,
    output to_slave_master_valid_1,
    output to_slave_read_en_1,
    output to_slave_write_en_1,
    output to_slave_tx_address_1,
    output to_slave_tx_data_1,
    output to_slave_tx_burst_1,
    output to_slave_tx_done_1,

    output to_slave_master_ready_2,
    output to_slave_master_valid_2,
    output to_slave_read_en_2,
    output to_slave_write_en_2,
    output to_slave_tx_address_2,
    output to_slave_tx_data_2,
    output to_slave_tx_burst_2,
    output to_slave_tx_done_2,

    output to_slave_master_ready_3,
    output to_slave_master_valid_3,
    output to_slave_read_en_3,
    output to_slave_write_en_3,
    output to_slave_tx_address_3,
    output to_slave_tx_data_3,
    output to_slave_tx_burst_3,
    output to_slave_tx_done_3
);


// slave 1 

assign to_slave_master_ready_1  =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_master_ready:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_master_ready: 1'b0;

assign to_slave_master_valid_1  =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_master_valid:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_master_valid: 1'b0;

assign to_slave_read_en_1       =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_read_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_read_en: 1'b0;

assign to_slave_write_en_1      =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_write_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_write_en: 1'b0;

assign to_slave_tx_address_1    =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_tx_address:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_tx_address: 1'b0;

assign to_slave_tx_data_1       =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_tx_data:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_tx_data: 1'b0;

assign to_slave_tx_burst_1      =   ((bus_grant == 2'b01) & (slave_grant == 3'b011)) ? m1_tx_burst:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b011)) ? m2_tx_burst: 1'b0;


// slave 2

assign to_slave_master_ready_2  =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_master_ready:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_master_ready: 1'b0;

assign to_slave_master_valid_2  =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_master_valid:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_master_valid: 1'b0;

assign to_slave_read_en_2       =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_read_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_read_en: 1'b0;

assign to_slave_write_en_2      =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_write_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_write_en: 1'b0;

assign to_slave_tx_address_2    =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_tx_address:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_tx_address: 1'b0;

assign to_slave_tx_data_2       =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_tx_data:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_tx_data: 1'b0;

assign to_slave_tx_burst_2      =   ((bus_grant == 2'b01) & (slave_grant == 3'b101)) ? m1_tx_burst:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b101)) ? m2_tx_burst: 1'b0;


// slave 3

assign to_slave_master_ready_3  =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_master_ready:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_master_ready: 1'b0;

assign to_slave_master_valid_3  =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_master_valid:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_master_valid: 1'b0;

assign to_slave_read_en_3       =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_read_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_read_en: 1'b0;

assign to_slave_write_en_3      =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_write_en:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_write_en: 1'b0;

assign to_slave_tx_address_3    =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_tx_address:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_tx_address: 1'b0;

assign to_slave_tx_data_3       =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_tx_data:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_tx_data: 1'b0;

assign to_slave_tx_burst_3      =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_tx_burst:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_tx_burst: 1'b0;

assign to_slave_tx_done_3      =   ((bus_grant == 2'b01) & (slave_grant == 3'b111)) ? m1_tx_done:
                                    ((bus_grant == 2'b10) & (slave_grant == 3'b111)) ? m2_tx_done: 1'b0;
  
endmodule