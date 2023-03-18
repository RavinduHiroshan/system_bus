module master_mux_old(
    input [1:0]bus_grant,
    input [2:0]slave_grant,

    input m1_master_ready,
    input m1_master_valid,
    input m1_read_en,
    input m1_write_en,
    input m1_tx_address,
    input m1_tx_data,
    input m1_tx_burst,

    input m2_master_ready,
    input m2_master_valid,
    input m2_read_en,
    input m2_write_en,
    input m2_tx_address,
    input m2_tx_data,
    input m2_tx_burst,
    
    output to_slave_master_ready_1,
    output to_slave_master_valid_1,
    output to_slave_read_en_1,
    output to_slave_write_en_1,
    output to_slave_tx_address_1,
    output to_slave_tx_data_1,
    output to_slave_tx_burst_1,

    output to_slave_master_ready_2,
    output to_slave_master_valid_2,
    output to_slave_read_en_2,
    output to_slave_write_en_2,
    output to_slave_tx_address_2,
    output to_slave_tx_data_2,
    output to_slave_tx_burst_2,

    output to_slave_master_ready_3,
    output to_slave_master_valid_3,
    output to_slave_read_en_3,
    output to_slave_write_en_3,
    output to_slave_tx_address_3,
    output to_slave_tx_data_3,
    output to_slave_tx_burst_3
);

wire to_slave_master_ready, 
 to_slave_master_valid,
 to_slave_read_en,
 to_slave_write_en,
 to_slave_tx_address,
 to_slave_tx_data,
 to_slave_tx_burst;


master_mux_mside master_mux_mside(
    .bus_grant(bus_grant),

    .m1_master_ready(m1_master_ready),
    .m1_master_valid(m1_master_valid),
    .m1_read_en(m1_read_en),
    .m1_write_en(m1_write_en),
    .m1_tx_address(m1_tx_address),
    .m1_tx_data(m1_tx_data),
    .m1_tx_burst(m1_tx_burst),

    .m2_master_ready(m2_master_ready),
    .m2_master_valid(m2_master_valid),
    .m2_read_en(m2_read_en),
    .m2_write_en(m2_write_en),
    .m2_tx_address(m2_tx_address),
    .m2_tx_data(m2_tx_data),
    .m2_tx_burst(m2_tx_burst),
    
    .to_slave_master_ready(to_slave_master_ready), 
    .to_slave_master_valid(to_slave_master_valid),
    .to_slave_read_en(to_slave_read_en),
    .to_slave_write_en(to_slave_write_en),
    .to_slave_tx_address(to_slave_tx_address),
    .to_slave_tx_data(to_slave_tx_data),
    .to_slave_tx_burst(to_slave_tx_burst)
);
master_mux_sside master_mux_sside(
    .slave_grant(slave_grant),

    .to_slave_master_ready(to_slave_master_ready), 
    .to_slave_master_valid(to_slave_master_valid),
    .to_slave_read_en(to_slave_read_en),
    .to_slave_write_en(to_slave_write_en),
    .to_slave_tx_address(to_slave_tx_address),
    .to_slave_tx_data(to_slave_tx_data),
    .to_slave_tx_burst(to_slave_tx_burst),

    .to_slave_master_ready_1(to_slave_master_ready_1),
    .to_slave_master_valid_1(to_slave_master_valid_1),
    .to_slave_read_en_1(to_slave_read_en_1),
    .to_slave_write_en_1(to_slave_write_en_1),
    .to_slave_tx_address_1(to_slave_tx_address_1),
    .to_slave_tx_data_1(to_slave_tx_data_1),
    .to_slave_tx_burst_1(to_slave_tx_burst_1),

    .to_slave_master_ready_2(to_slave_master_ready_2),
    .to_slave_master_valid_2(to_slave_master_valid_2),
    .to_slave_read_en_2(to_slave_read_en_2),
    .to_slave_write_en_2(to_slave_write_en_2),
    .to_slave_tx_address_2(to_slave_tx_address_2),
    .to_slave_tx_data_2(to_slave_tx_data_2),
    .to_slave_tx_burst_2(to_slave_tx_burst_2),

    .to_slave_master_ready_3(to_slave_master_ready_3),
    .to_slave_master_valid_3(to_slave_master_valid_3),
    .to_slave_read_en_3(to_slave_read_en_3),
    .to_slave_write_en_3(to_slave_write_en_3),
    .to_slave_tx_address_3(to_slave_tx_address_3),
    .to_slave_tx_data_3(to_slave_tx_data_3),
    .to_slave_tx_burst_3(to_slave_tx_burst_3)

);



    
endmodule